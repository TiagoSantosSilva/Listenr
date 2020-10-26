//
//  DependencyContainer.swift
//  CoreKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import Foundation
import NetworkingKit

public protocol DependencyContainable {
    var networkProvider: NetworkProvidable { get }
    
    init()
}

public final class DependencyContainer: DependencyContainable {
    
    // MARK: - Dependencies
    
    public let networkProvider: NetworkProvidable
    
    // MARK: - Initialization
    
    public init() {
        let networkEngine = NetworkEngine(builder: NetworkRequestBuilder(queryParameterBuilder: NetworkRequestQueryParameterBuilder()),
                                          diskProvider: DiskProvider(),
                                          parser: NetworkResponseParser(diskProvider: DiskProvider()))
        self.networkProvider = NetworkProvider(engine: networkEngine)
    }
}
