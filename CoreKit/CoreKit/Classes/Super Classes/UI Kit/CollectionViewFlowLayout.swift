//
//  CollectionViewFlowLayout.swift
//  CoreKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import UIKit

open class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Initialization
    
    override public init() {
        super.init()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError(UIKitError.unavailableXIB)
    }
}
