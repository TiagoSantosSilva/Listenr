//
//  ChartTopTagsCollectionViewController.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import UIKit

protocol ChartTopTagsCollectionViewControllerDelegate: class {
    func collectionViewController(_ collectionViewController: ChartTopTagsCollectionViewController, didSelectItemAt indexPath: IndexPath)
}

final class ChartTopTagsCollectionViewController: CollectionViewController {
    
    // MARK: - Properties
    
    private let dataSource: ChartTopTagsDataSourceable
    
    // MARK: - Delegate
    
    weak var delegate: ChartTopTagsCollectionViewControllerDelegate?
    
    // MARK: - Initialization
    
    init(dataSource: ChartTopTagsDataSourceable, viewModel: ChartTopTagsViewModelable) {
        self.dataSource = dataSource
        let layout = ChartTopTagsCollectionViewLayout()
        super.init(collectionViewLayout: layout)
        self.collectionView = ChartTopTagsCollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    // MARK: - Functions
    
    func setup() {
        self.collectionView.dataSource = self.dataSource
    }
}

// MARK: - UI Collection View Controller Delegate

extension ChartTopTagsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewController(self, didSelectItemAt: indexPath)
    }
}
