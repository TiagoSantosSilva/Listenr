//
//  CollectionViewCell.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

open class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError(UIKitError.unavailableXIB)
    }
    
    // MARK: - Functions
    
    public func roundCorners() {
        let contentViewLayer = contentView.layer
        contentViewLayer.cornerRadius = 10
        contentViewLayer.borderWidth = 1.0
        contentViewLayer.borderColor = UIColor.clear.cgColor
        contentViewLayer.masksToBounds = true
    }
}
