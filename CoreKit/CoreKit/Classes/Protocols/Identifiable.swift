//
//  Identifiable.swift
//  CoreKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import UIKit

protocol Identifiable {}

extension Identifiable {
    public var name: String { return String(describing: self) }
    public static var name: String { return String(describing: self) }
}

extension Identifiable where Self: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
}
