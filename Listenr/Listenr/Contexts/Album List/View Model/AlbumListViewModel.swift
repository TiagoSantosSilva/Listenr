//
//  AlbumListViewModel.swift
//  Listenr
//
//  Created by Tiago Silva on 24/10/2020.
//

import CoreKit
import Foundation

protocol AlbumListViewModelDelegate: ServiceFailRecoverDelegate {
    func viewModel(_ viewModel: AlbumListViewModel, didLoadAlbumsAt indexPaths: [IndexPath])
    func viewModelDidLoadFirstAlbumBatch(_ viewModel: AlbumListViewModel)
}

protocol AlbumListViewModelable: class {
    var selectedTag: ChartTopTag { get }
    var albums: [Album?] { get }
    var delegate: AlbumListViewModelDelegate? { get set }
    
    init(loader: AlbumListLoadable, queue: DispatchQueue)
    
    func loadAlbums(at indexPath: IndexPath)
    func reloadData(for tag: ChartTopTag)
}

private enum Status {
    case loading
    case reloading
    case userInteracting
}

final class AlbumListViewModel: AlbumListViewModelable {
    
    // MARK: - Properties
    
    var selectedTag: ChartTopTag = Constants.defaultTag
    var albums: [Album?] = []
    private var pageRequestsStatuses: [PageRequestStatus] = []
    private var status: Status = .loading
    private var itemsPerPage: Int?
    
    // MARK: - Queues
    
    private let queue: DispatchQueue
    
    // MARK: - Loader
    
    private let loader: AlbumListLoadable
    
    // MARK: - Delegate
    
    weak var delegate: AlbumListViewModelDelegate?
    
    // MARK: - Constants
    
    private enum Constants {
        static let firstPage: Int = 1
        static let maximumNumberOfAlbums: Int = 1000
        static let defaultTag: ChartTopTag = .init(name: "Hip-Hop")
    }
    
    // MARK: - Initialization
    
    required init(loader: AlbumListLoadable, queue: DispatchQueue = .init(label: #file)) {
        self.loader = loader
        self.queue = queue
    }
    
    // MARK: - Functions
    
    func loadAlbums(at indexPath: IndexPath) {
        PaginationFunctions.performPaginatedLoadIfNeeded(at: indexPath.row,
                                                         itemsPerPage: itemsPerPage,
                                                         expectedTotalItems: albums.isEmpty ? nil : albums.count,
                                                         currentResults: &self.pageRequestsStatuses,
                                                         loadHandler: { [weak self] page in
                                                            self?.loadAlbums(for: page)
                                                         })
    }
    
    func reloadData(for tag: ChartTopTag) {
        self.selectedTag = tag
        self.status = .reloading
        self.pageRequestsStatuses.removeAll()
        self.loadAlbums(at: .zero)
    }
    
    // MARK: - Private Functions
    
    private func loadAlbums(for page: Int) {
        loader.loadAlbums(at: page, tag: selectedTag) { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case let .success(result):
                self.assignSucceededRequestStatus(for: page)
                switch self.status {
                case .loading:
                    self.handleLoadOfFirstAlbumBatch(values: result, at: page)
                case .reloading:
                    guard page == Constants.firstPage else { return }
                    self.handleLoadOfFirstAlbumBatch(values: result, at: page)
                case .userInteracting:
                    self.handleLoadOfIncrementedAlbumBatch(values: result, at: page)
                }
            case .failure:
                self.handleLoadFailure(at: page)
            }
        }
    }
    
    private func assignSucceededRequestStatus(for page: Int) {
        result(for: page) { result in
            guard let result = result else { return }
            result.requestStatus = .succeeded
        }
    }
    
    private func handleLoadOfFirstAlbumBatch(values: AlbumValues, at page: Int) {
        guard let attributesTotal = Int(values.attributes.total) else { return }
        let total: Int = attributesTotal <= Constants.maximumNumberOfAlbums ? attributesTotal : Constants.maximumNumberOfAlbums
        self.albums = (0..<total).map { _ in nil }
        self.itemsPerPage = Int(values.attributes.perPage)
        self.assignNewAlbums(values.albums, for: page)
        self.status = .userInteracting
        self.delegate?.viewModelDidLoadFirstAlbumBatch(self)
    }
    
    private func handleLoadOfIncrementedAlbumBatch(values: AlbumValues, at page: Int) {
        guard let itemsPerPage = self.itemsPerPage else { return }
        self.assignNewAlbums(values.albums, for: page)
        let indexPaths = PaginationFunctions.indexPaths(itemsPerPage: itemsPerPage,
                                                        itemCount: self.albums.count,
                                                        page: page)
        delegate?.viewModel(self, didLoadAlbumsAt: indexPaths)
    }
    
    private func handleLoadFailure(at page: Int) {
        result(for: page) { [weak self] result in
            guard let result = result else {
                guard let self = self else { return }
                guard self.status == .loading || self.status == .reloading else { return }
                self.delegate?.viewModelDidFailServiceCall(self) { [weak self] in
                    self?.loadAlbums(at: .zero)
                }
                return
            }
            result.requestStatus = .failed
        }
    }
    
    private func result(for page: Int, completion: @escaping (_ status: PageRequestStatus?) -> Void) {
        queue.async {
            completion(self.pageRequestsStatuses.first(where: { $0.page == page }))
        }
    }
    
    private func assignNewAlbums(_ newAlbums: [Album], for page: Int) {
        PaginationFunctions.assign(items: newAlbums,
                                   to: &self.albums,
                                   at: page,
                                   itemsPerPage: itemsPerPage)
    }
}
