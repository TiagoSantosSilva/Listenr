//
//  NetworkError.swift
//  NetworkingKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import Foundation

public enum NetworkError: Error {
    case decodeFailed
    case noData
    case requestFailed
    case sessionExpired
    case outdated
    case urlBuildFailed
}
