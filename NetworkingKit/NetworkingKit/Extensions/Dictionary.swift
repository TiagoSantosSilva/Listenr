//
//  Dictionary.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 26/10/2020.
//

import Foundation

public extension Dictionary where Key: Comparable {
    func ascendedSortByKey() -> [(key: Key, value: Value)] {
        return sorted( by: { $0.0 < $1.0 })
    }
}
