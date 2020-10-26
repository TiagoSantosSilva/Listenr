//
//  EndpointTests.swift
//  NetworkingKitTests
//
//  Created by Tiago Silva on 26/10/2020.
//

@testable import NetworkingKit
import XCTest

final class EndpointTests: XCTestCase {
    
    // MARK: - Constants
    
    private enum Constants {
        static let endpointWithDefaultInitiation: Endpoint<String> = .init(path: "/path")
    }
    
    // MARK: - Functions
    
    func testInitilizationDefaultMethodGet() {
        XCTAssertEqual(Constants.endpointWithDefaultInitiation.method, .get)
    }
    
    func testInitializationDefaultQueryParametersIsEmpty() {
        XCTAssert(Constants.endpointWithDefaultInitiation.queryParameters.isEmpty)
    }
}
