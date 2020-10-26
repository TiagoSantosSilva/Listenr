//
//  NetworkRequestQueryParameterBuilder.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 26/10/2020.
//

import Foundation

public protocol NetworkRequestQueryParameterBuildable {
    init()
    
    func build<T>(components: inout URLComponents, endpoint: Endpoint<T>)
}

public final class NetworkRequestQueryParameterBuilder: NetworkRequestQueryParameterBuildable {
    
    // MARK: - Constants
    
    private enum Constants {
        static let methodKey: String = "method"
        static let apiKeyKey: String = "api_key"
        static let formatQueryItem: URLQueryItem = .init(name: "format", value: "json")
    }
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Functions
    
    public func build<T>(components: inout URLComponents, endpoint: Endpoint<T>) where T : Decodable {
        components.queryItems?.append(.init(name: Constants.methodKey, value: endpoint.path))
        components.queryItems?.append(.init(name: Constants.apiKeyKey, value: PropertyList.string(for: .apiKey)))
        components.queryItems?.append(Constants.formatQueryItem)
    }
}
