//
//  NetworkRequestBuilder.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import Foundation

public protocol NetworkRequestBuildable: class {
    init(queryParameterBuilder: NetworkRequestQueryParameterBuildable)
    
    func build<T: Decodable>(endpoint: Endpoint<T>) throws -> URLRequest
}

public final class NetworkRequestBuilder: NetworkRequestBuildable {
    
    // MARK: - Dependencies
    
    private lazy var encoder: JSONEncoder = .init()
    private let queryParameterBuilder: NetworkRequestQueryParameterBuildable
    
    // MARK: - Initialization
    
    public init(queryParameterBuilder: NetworkRequestQueryParameterBuildable) {
        self.queryParameterBuilder = queryParameterBuilder
    }
    
    // MARK: - Functions
    
    public func build<T: Decodable>(endpoint: Endpoint<T>) throws -> URLRequest {
        guard let url = URL(string: endpoint.base) else {
            throw NetworkError.requestFailed
        }
        
        var request = URLRequest(url: url)
        buildHTTPMethod(request: &request, endpoint: endpoint)
        try buildQueryParameters(request: &request, endpoint: endpoint)
        return request
    }
    
    // MARK: - Private Functions
    
    private func buildHTTPMethod<T>(request: inout URLRequest, endpoint: Endpoint<T>) {
        request.httpMethod = endpoint.method.rawValue
    }
    
    private func buildQueryParameters<T>(request: inout URLRequest, endpoint: Endpoint<T>) throws {
        guard let url = request.url else { throw NetworkError.urlBuildFailed }
        let parameters = endpoint.queryParameters
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        components.queryItems = [URLQueryItem]()
        
        parameters.forEach {
            components.queryItems?.append($0)
        }
        queryParameterBuilder.build(components: &components, endpoint: endpoint)
        request.url = components.url
    }
}
