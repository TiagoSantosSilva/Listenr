//
//  CollectionViewController.swift
//  CoreKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import UIKit

open class CollectionViewController: UICollectionViewController {
    
    // MARK: - Initialization
    
    override public init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError(UIKitError.unavailableXIB)
    }
}
