//
//  ChartTopTagsCollectionViewLayout.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import UIKit

final class ChartTopTagsCollectionViewLayout: CollectionViewFlowLayout {
    
    // MARK: - Constants
    
    private enum Constants {
        enum Item {
            static let width: CGFloat = UIScreen.main.bounds.width - Insets.left - Insets.right
            static let height: CGFloat = 60
        }
        
        enum Insets {
            static let left: CGFloat = 16
            static let right: CGFloat = left
            static let top: CGFloat = 16
            static let bottom: CGFloat = top
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
        self.sectionInset = .init(top: Constants.Insets.top,
                                  left: Constants.Insets.left,
                                  bottom: Constants.Insets.bottom,
                                  right: Constants.Insets.right)
        self.minimumLineSpacing = 16
    }
}
