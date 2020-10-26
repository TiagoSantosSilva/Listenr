//
//  NetworkEngine.swift
//  NetworkingKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import Foundation

public protocol NetworkEnginable: class {
    init(builder: NetworkRequestBuildable, parser: NetworkResponseParseable)
    
    func request<T: Decodable>(endpoint: Endpoint<T>, completion: @escaping NetworkCompletion<T>)
}

public final class NetworkEngine: NSObject, NetworkEnginable, URLSessionDelegate {
    
    // MARK: - Dependencies
    
    private let builder: NetworkRequestBuildable
    private let parser: NetworkResponseParseable
    
    // MARK: - Session
    
    private var session: URLSession?
    
    // MARK: - Initialization
    
    public init(builder: NetworkRequestBuildable, parser: NetworkResponseParseable) {
        self.builder = builder
        self.parser = parser
        super.init()
        self.session = .init(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    // MARK: - Public Functions
    
    public func request<T: Decodable>(endpoint: Endpoint<T>, completion: @escaping NetworkCompletion<T>) {
        do {
            let request = try builder.build(endpoint: endpoint)
            print("URL: \(String(describing: request.url)) 🧩")
            runTask(for: request, completion: completion)
        } catch {
            completion(.failure(.urlBuildFailed))
        }
    }
    
    // MARK: - Private Functions
    
    private func runTask<T: Decodable>(for request: URLRequest, completion: @escaping NetworkCompletion<T>) {
        session?.dataTask(with: request) { [weak self] data, response, _ in
            self?.parser.parse(response: response, data: data, completion: completion)
        }.resume()
    }
}
