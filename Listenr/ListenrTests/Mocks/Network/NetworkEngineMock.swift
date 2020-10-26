//
//  NetworkEngineMock.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
import Foundation
import NetworkingKit
@testable import Listenr

final class NetworkEngineMock: NetworkEnginable {
    
    // MARK: -
    
    var result: AnyDecodable!
    var error: NetworkError!
    var resultType: Result<Void, NetworkError>!
    
    // MARK: -
    
    private let builder: NetworkRequestBuildable
    private let diskProvider: DiskProvidable
    private let parser: NetworkResponseParseable
    
    // MARK: - Initialization
    
    init(builder: NetworkRequestBuildable, diskProvider: DiskProvidable, parser: NetworkResponseParseable) {
        self.builder = builder
        self.diskProvider = diskProvider
        self.parser = parser
    }
    
    // MARK: - Functions
    
    func request<T: Decodable>(endpoint: Endpoint<T>, completion: @escaping NetworkCompletion<T>) {
        guard let completion = completion as? NetworkCompletion<AnyDecodable>,
            let resultType = resultType else { fatalError() }
        switch resultType {
        case .success:
            completion(.success(result))
        case .failure:
            completion(.failure(error))
        }
    }
}
