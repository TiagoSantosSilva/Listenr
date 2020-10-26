//
//  IndexPath.swift
//  CoreKit
//
//  Created by Tiago Santos on 25/10/2020.
//

import Foundation

public extension IndexPath {

    // MARK: - Initialization

    init(row: Int) {
        self.init(row: row, section: 0)
    }

    init(section: Int) {
        self.init(row: 0, section: section)
    }
    
    // MARK: - Constants
    
    static let zero: IndexPath = IndexPath(row: 0, section: 0)
}
