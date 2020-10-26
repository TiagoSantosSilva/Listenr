//
//  AlbumListLoader.swift
//  Listenr
//
//  Created by Tiago Santos on 24/10/2020.
//

import CoreKit
import Foundation
import NetworkingKit

protocol AlbumListLoadable {
    init(dependencies: DependencyContainable)
    
    func loadAlbums(at index: Int, tag: ChartTopTag, completion: @escaping AlbumListLoadCompletion)
}

enum AlbumLoadError: Error {
    case failed
}

typealias AlbumListLoadCompletion = (_ result: Result<AlbumValues, AlbumLoadError>) -> Void

final class AlbumListLoader: AlbumListLoadable {
    
    // MARK: - Dependencies
    
    private let networkProvider: NetworkProvidable
    
    // MARK: - Initialization
    
    required init(dependencies: DependencyContainable) {
        self.networkProvider = dependencies.networkProvider
    }
    
    // MARK: - Functions
    
    func loadAlbums(at index: Int, tag: ChartTopTag, completion: @escaping AlbumListLoadCompletion) {
        networkProvider.request(endpoint: .albums(at: index, tag: tag)) {
            switch $0 {
            case let .success(result):
                completion(.success(result.values))
            case let .failure(fail):
                print("Fail: \(fail)")
                completion(.failure(.failed))
            }
        }
    }
}
