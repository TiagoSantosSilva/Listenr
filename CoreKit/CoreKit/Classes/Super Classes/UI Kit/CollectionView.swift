//
//  CollectionView.swift
//  CoreKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import UIKit

open class CollectionView: UICollectionView {
    
    // MARK: - Initialization
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError(UIKitError.unavailableXIB)
    }
    
    // MARK: - Functions
    
    open func setup() {
        alwaysBounceVertical = true
    }
}
