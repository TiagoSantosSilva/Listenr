//
//  NetworkEngine.swift
//  NetworkingKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import Foundation
import Network

public protocol NetworkEnginable: class {
    init(builder: NetworkRequestBuildable, diskProvider: DiskProvidable, parser: NetworkResponseParseable)
    
    func request<T: Decodable>(endpoint: Endpoint<T>, completion: @escaping NetworkCompletion<T>)
}

public final class NetworkEngine: NSObject, NetworkEnginable, URLSessionDelegate {
    
    // MARK: - Dependencies
    
    private let builder: NetworkRequestBuildable
    private let diskProvider: DiskProvidable
    private let parser: NetworkResponseParseable
    private let monitor: NWPathMonitor = .init()
    
    // MARK: - Session
    
    private var session: URLSession?
    
    // MARK: - Properties
    
    private var hasInternetConnection: Bool = true
    
    // MARK: - Initialization
    
    public init(builder: NetworkRequestBuildable,
                diskProvider: DiskProvidable,
                parser: NetworkResponseParseable) {
        self.builder = builder
        self.diskProvider = diskProvider
        self.parser = parser
        super.init()
        self.session = .init(configuration: .default, delegate: self, delegateQueue: nil)
        setupMonitor()
    }
    
    // MARK: - Setups
    
    private func setupMonitor() {
        monitor.pathUpdateHandler = { [weak self] in
            switch $0.status {
            case .satisfied:
                self?.hasInternetConnection = true
            case .requiresConnection, .unsatisfied:
                self?.hasInternetConnection = false
            @unknown default:
                return
            }
        }
        let queue = DispatchQueue(label: #file)
        monitor.start(queue: queue)
    }
    
    // MARK: - Public Functions
    
    public func request<T: Decodable>(endpoint: Endpoint<T>, completion: @escaping NetworkCompletion<T>) {
        do {
            let request = try builder.build(endpoint: endpoint)
            if let data = diskProvider.read(request: request, isOnline: self.hasInternetConnection) {
                parser.parseCachedData(data: data, completion: completion)
                return
            }
            print("URL: \(String(describing: request.url)) 🧩")
            runTask(for: request, completion: completion)
        } catch {
            completion(.failure(.urlBuildFailed))
        }
    }
    
    // MARK: - Private Functions
    
    private func runTask<T: Decodable>(for request: URLRequest, completion: @escaping NetworkCompletion<T>) {
        session?.dataTask(with: request) { [weak self] data, response, _ in
            self?.parser.parse(response: response, request: request, data: data, completion: completion)
        }.resume()
    }
}
