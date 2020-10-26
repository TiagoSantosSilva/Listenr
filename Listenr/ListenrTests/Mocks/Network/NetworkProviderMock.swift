//
//  NetworkProviderMock.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import Foundation
import NetworkingKit
@testable import Listenr

final class NetworkProviderMock: NetworkProvidable {
    
    var engine: NetworkEnginable!
    
    init(engine: NetworkEnginable) {
        self.engine = engine
    }
    
    func request<T>(endpoint: Endpoint<T>, completion: @escaping NetworkCompletion<T>) where T : Decodable {
        engine.request(endpoint: endpoint, completion: completion)
    }
}
