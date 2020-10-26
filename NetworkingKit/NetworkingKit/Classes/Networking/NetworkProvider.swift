//
//  NetworkProvider.swift
//  NetworkingKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import Foundation

public protocol NetworkProvidable {
    
    init(engine: NetworkEnginable)
    
    func request<T: Decodable>(endpoint: Endpoint<T>, completion: @escaping NetworkCompletion<T>)
}

public final class NetworkProvider: NetworkProvidable {
    
    // MARK: - Dependencies
    
    private let engine: NetworkEnginable
    
    // MARK: - Initialization
    
    public init(engine: NetworkEnginable) {
        self.engine = engine
    }
    
    // MARK: - Functions
    
    public func request<T: Decodable>(endpoint: Endpoint<T>, completion: @escaping NetworkCompletion<T>) {
        engine.request(endpoint: endpoint, completion: completion)
    }
}
