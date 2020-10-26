//
//  Endpoint.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import Foundation

public struct Endpoint<T: Decodable> {
    public let base: String
    public let method: HTTPMethod
    public let path: String
    public let queryParameters: [URLQueryItem]
    
    public init(base: String, method: HTTPMethod, path: String, queryParameters: [URLQueryItem]) {
        self.base = base
        self.method = method
        self.path = path
        self.queryParameters = queryParameters
    }
}

public extension Endpoint {
    init(method: HTTPMethod = .get, path: String, queryParameters: [URLQueryItem] = []) {
        self.init(base: NetworkConstants.baseURL,
                  method: method,
                  path: path,
                  queryParameters: queryParameters)
    }
}
