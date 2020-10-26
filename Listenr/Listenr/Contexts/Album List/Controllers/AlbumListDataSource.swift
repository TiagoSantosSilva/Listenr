//
//  AlbumListDataSource.swift
//  Listenr
//
//  Created by Tiago Santos on 24/10/2020.
//

import UIKit

protocol AlbumListDataSourceable: UICollectionViewDataSource {
    init(viewModel: AlbumListViewModelable)
}

final class AlbumListDataSource: NSObject, AlbumListDataSourceable {
    
    // MARK: - View Model
    
    private let viewModel: AlbumListViewModelable
    
    // MARK: - Initialization
    
    init(viewModel: AlbumListViewModelable) {
        self.viewModel = viewModel
        super.init()
    }
}

// MARK: - UI Collection View Data Source

extension AlbumListDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AlbumListCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let album = viewModel.albums[indexPath.row] else { return cell }
        cell.configure(with: album)
        return cell
    }
}
