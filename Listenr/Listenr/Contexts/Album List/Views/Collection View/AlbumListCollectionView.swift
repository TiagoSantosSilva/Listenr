//
//  AlbumListCollectionView.swift
//  Listenr
//
//  Created by Tiago Silva on 24/10/2020.
//

import CoreKit
import UIKit

final class AlbumListCollectionView: CollectionView {
    
    // MARK: - Setups
    
    override func setup() {
        super.setup()
        registerClasses()
        setupStyles()
    }
    
    private func registerClasses() {
        registerCellClass(AlbumListCell.self)
    }
    
    private func setupStyles() {
        self.backgroundColor = Color.backgroundGray
    }
}
