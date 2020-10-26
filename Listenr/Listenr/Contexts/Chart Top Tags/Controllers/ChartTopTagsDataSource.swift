//
//  ChartTopTagsDataSource.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

protocol ChartTopTagsDataSourceable: UICollectionViewDataSource {
    init(viewModel: ChartTopTagsViewModelable)
}

final class ChartTopTagsDataSource: NSObject, ChartTopTagsDataSourceable {
    
    // MARK: - View Model
    
    private let viewModel: ChartTopTagsViewModelable
    
    // MARK: - Initialization
    
    init(viewModel: ChartTopTagsViewModelable) {
        self.viewModel = viewModel
        super.init()
    }
}

// MARK: - UI Collection View Data Source

extension ChartTopTagsDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChartTopTagsCell = collectionView.dequeueReusableCell(for: indexPath)
        let tag = viewModel.tags[indexPath.row]
        cell.configure(with: tag, isSelected: viewModel.isTagSelected(tag: tag))
        return cell
    }
}
