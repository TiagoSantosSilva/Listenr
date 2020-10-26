//
//  AlbumListCollectionViewController.swift
//  Listenr
//
//  Created by Tiago Santos on 24/10/2020.
//

import CoreKit
import UIKit

protocol AlbumListCollectionViewControllerDelegate: class {
    func collectionViewController(_ collectionViewController: AlbumListCollectionViewController, didSelectItemAt indexPath: IndexPath)
}

final class AlbumListCollectionViewController: CollectionViewController {
    
    // MARK: - View Model
    
    private let viewModel: AlbumListViewModelable
    
    // MARK: - Data Source
    
    private let dataSource: AlbumListDataSourceable
    
    // MARK: - Delegate
    
    weak var delegate: AlbumListCollectionViewControllerDelegate?
    
    // MARK: - Initialization
    
    init(viewModel: AlbumListViewModelable, dataSource: AlbumListDataSourceable) {
        self.viewModel = viewModel
        self.dataSource = dataSource
        let layout = AlbumListCollectionViewLayout()
        super.init(collectionViewLayout: layout)
        self.collectionView = AlbumListCollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    // MARK: - Functions
    
    func setup() {
        collectionView.dataSource = dataSource
        collectionView.prefetchDataSource = self
    }
}

// MARK: - UI Collection View Delegate

extension AlbumListCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewController(self, didSelectItemAt: indexPath)
    }
}

// MARK: - UI Collection View Data Source Prefetching

extension AlbumListCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.last else { return }
        viewModel.loadAlbums(at: indexPath)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = collectionView.indexPathsForVisibleItems.last else { return }
        viewModel.loadAlbums(at: indexPath)
    }
}
