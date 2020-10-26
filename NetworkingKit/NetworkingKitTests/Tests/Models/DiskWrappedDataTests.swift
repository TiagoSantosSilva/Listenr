//
//  DiskWrappedDataTests.swift
//  NetworkingKitTests
//
//  Created by Tiago Silva on 26/10/2020.
//

@testable import NetworkingKit
import XCTest

final class DiskWrappedDataTests: XCTestCase {
    
    // MARK: - Constants
    
    private enum Constants {
        enum TestingValues {
            static let time: Int = Int(Date().timeIntervalSince1970)
            static let data: DiskWrappedData = .init(data: .init())
        }
    }
    
    // MARK: - Functions
    
    func testDataTimeEqualToExpected() {
        XCTAssertEqual(Constants.TestingValues.time, Constants.TestingValues.data.creationTime)
    }
}
