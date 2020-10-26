//
//  Array.swift
//  CoreKit
//
//  Created by Tiago Santos on 25/10/2020.
//

import Foundation

public extension Array where Element: Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }

    subscript(safe index: Int) -> Element? {
        return index < count ? self[index] : nil
    }
}
