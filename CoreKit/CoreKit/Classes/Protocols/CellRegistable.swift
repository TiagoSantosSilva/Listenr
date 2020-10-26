//
//  CellRegistable.swift
//  CoreKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import UIKit

public protocol CellRegistable {}

public extension CellRegistable where Self: UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.name, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func registerCellClass<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { cellType in
            register(cellType)
        }
    }
}
