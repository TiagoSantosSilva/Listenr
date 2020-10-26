//
//  ChartTopTagsCollectionView.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import CoreKit
import UIKit

final class ChartTopTagsCollectionView: CollectionView {
    
    // MARK: - Setups
    
    override func setup() {
        super.setup()
        registerClasses()
        setupStyles()
    }
    
    private func registerClasses() {
        registerCellClass(ChartTopTagsCell.self)
    }
    
    private func setupStyles() {
        self.backgroundColor = Color.backgroundGray
    }
}
