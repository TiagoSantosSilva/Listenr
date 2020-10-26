//
//  AlbumListViewController.swift
//  Listenr
//
//  Created by Tiago Santos on 24/10/2020.
//

import CoreKit
import UIKit

protocol AlbumListViewControllerDelegate: class {
    func viewController(_ viewController: AlbumListViewController, didSelect album: Album)
    func viewController(_ viewController: AlbumListViewController, didTapTagsButtonFor selectedTag: ChartTopTag)
}

final class AlbumListViewController: ViewController {
    
    // MARK: - View Model
    
    private let viewModel: AlbumListViewModelable
    
    // MARK: - Subviews
    
    private let collectionViewController: AlbumListCollectionViewController
    
    // MARK: - Delegate
    
    weak var delegate: AlbumListViewControllerDelegate?
    
    // MARK: - Initialization
    
    init(viewModel: AlbumListViewModelable) {
        self.viewModel = viewModel
        self.collectionViewController = AlbumListCollectionViewController(viewModel: viewModel, dataSource: AlbumListDataSource(viewModel: viewModel))
        super.init()
        self.viewModel.delegate = self
        self.collectionViewController.delegate = self
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    // MARK: - Functions
    
    func reload(for tag: ChartTopTag) {
        displayLoadingView()
        self.collectionViewController.collectionView.scrollToItem(at: .zero, at: .bottom, animated: false)
        self.navigationItem.title = tag.name
        viewModel.reloadData(for: tag)
    }
    
    // MARK: - Setups
    
    private func setupController() {
        setupCollectionViewController()
        setupNavigationItem()
        displayLoadingView()
        viewModel.loadAlbums(at: .zero)
    }
    
    private func setupCollectionViewController() {
        add(child: collectionViewController)
        collectionViewController.setup()
    }
    
    private func setupNavigationItem() {
        let button: UIBarButtonItem = .init(title: "Tags", style: .plain, target: self, action: #selector(tagsButtonWasTapped))
        navigationItem.setRightBarButton(button, animated: false)
        navigationItem.title = viewModel.selectedTag.name
    }
    
    // MARK: - Selectors
    
    @objc private func tagsButtonWasTapped(_ sender: UIBarButtonItem) {
        delegate?.viewController(self, didTapTagsButtonFor: viewModel.selectedTag)
    }
}

// MARK: - Album List View Model Delegate

extension AlbumListViewController: AlbumListViewModelDelegate {
    func viewModelDidLoadFirstAlbumBatch(_ viewModel: AlbumListViewModel) {
        DispatchQueue.main.async {
            self.collectionViewController.collectionView.reloadData()
            self.hideLoadingView()
        }
    }
    
    func viewModel(_ viewModel: AlbumListViewModel, didLoadAlbumsAt indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.collectionViewController.collectionView.reloadItems(at: indexPaths)
        }
    }
}

// MARK: - Album List Collection View Controller Delegate

extension AlbumListViewController: AlbumListCollectionViewControllerDelegate {
    func collectionViewController(_ collectionViewController: AlbumListCollectionViewController, didSelectItemAt indexPath: IndexPath) {
        guard let album = viewModel.albums[indexPath.row] else { return }
        delegate?.viewController(self, didSelect: album)
    }
}
