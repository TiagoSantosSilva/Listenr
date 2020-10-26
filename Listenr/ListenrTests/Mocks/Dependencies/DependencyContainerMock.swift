//
//  DependencyContainerMock.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
import Foundation
import NetworkingKit
@testable import Listenr

final class DependencyContainerMock: DependencyContainable {
    
    let networkProvider: NetworkProvidable
    
    init() {
        let builder = NetworkRequestBuilder(queryParameterBuilder: NetworkRequestQueryParameterBuilder())
        let diskProvider = DiskProvider()
        let parser = NetworkResponseParser(diskProvider: diskProvider)
        self.networkProvider = NetworkProviderMock(engine: NetworkEngineMock(builder: builder,
                                                                             diskProvider: diskProvider,
                                                                             parser: parser))
    }
    
    init(networkProvider: NetworkProviderMock) {
        self.networkProvider = networkProvider
    }
}
