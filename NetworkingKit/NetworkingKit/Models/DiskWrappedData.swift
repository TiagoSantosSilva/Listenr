//
//  DiskWrappedData.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 26/10/2020.
//

import Foundation

final class DiskWrappedData: Codable {
    
    let data: Data
    let creationTime: Int
    
    init(data: Data) {
        self.data = data
        self.creationTime = Int(Date().timeIntervalSince1970)
    }
}
