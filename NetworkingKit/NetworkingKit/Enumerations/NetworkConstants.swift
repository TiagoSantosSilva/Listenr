//
//  NetworkConstants.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import Foundation

enum NetworkConstants {
    static var baseURL: String = {
        guard let value = PropertyList.string(for: .backendURL) else { fatalError("Could not find the value Backend URL.") }
        return value
    }()
}
