//
//  AlbumDetailsViewModel.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import Foundation
import NetworkingKit

protocol AlbumDetailsViewModelDelegate: ServiceFailRecoverDelegate {
    func viewModel(_ viewModel: AlbumDetailsViewModel, didLoad details: AlbumInformation)
}

protocol AlbumDetailsViewModelable: class {
    var albumName: String { get }
    var delegate: AlbumDetailsViewModelDelegate? { get set }
    var information: AlbumInformation? { get }
    
    func loadDetails()
}

final class AlbumDetailsViewModel: AlbumDetailsViewModelable {
    
    // MARK: - Dependencies
    
    private let networkProvider: NetworkProvidable
    
    // MARK: - Properties
    
    var albumName: String {
        return album.name
    }
    var information: AlbumInformation?
    private let album: Album
    
    // MARK: - Delegate
    
    weak var delegate: AlbumDetailsViewModelDelegate?
    
    // MARK: - Initialization
    
    init(album: Album, dependencies: DependencyContainable) {
        self.album = album
        self.networkProvider = dependencies.networkProvider
    }
    
    // MARK: - Functions
    
    func loadDetails() {
        networkProvider.request(endpoint: .albumInformation(album: album)) { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case let .success(result):
                self.information = result.information
                self.delegate?.viewModel(self, didLoad: result.information)
            case .failure:
                self.delegate?.viewModelDidFailServiceCall(self) { [weak self] in
                    self?.loadDetails()
                }
            }
        }
    }
}
