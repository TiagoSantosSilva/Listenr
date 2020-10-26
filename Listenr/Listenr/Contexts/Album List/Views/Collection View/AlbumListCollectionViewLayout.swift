//
//  AlbumListCollectionViewLayout.swift
//  Listenr
//
//  Created by Tiago Silva on 24/10/2020.
//

import CoreKit
import UIKit

final class AlbumListCollectionViewLayout: CollectionViewFlowLayout {
    
    // MARK: - Constants
    
    private enum Constants {
        enum Item {
            static let width: CGFloat = 150
            static let height: CGFloat = 220
        }
    }
    
    // MARK: - Setups
    
    override init() {
        super.init()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupLayout() {
        self.itemSize = .init(width: Constants.Item.width, height: Constants.Item.height)
        self.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
    }
}
