//
//  IndexPathTests.swift
//  CoreKitTests
//
//  Created by Tiago Silva on 26/10/2020.
//

@testable import CoreKit
import XCTest

final class IndexPathTests: XCTestCase {
    
    // MARK: - Constants
    
    private enum Constants {
        enum TestingValues {
            static let row: Int = 3
            static let section: Int = 10
        }
        
        enum Expected {
            static let indexPathFromRowInit: IndexPath = .init(row: TestingValues.row, section: 0)
            static let indexPathFromSectionInit: IndexPath = .init(row: 0, section: TestingValues.section)
        }
    }
    
    // MARK: - Functions
    
    func testRowInit() {
        let result = IndexPath(row: Constants.TestingValues.row)
        XCTAssertEqual(result, Constants.Expected.indexPathFromRowInit)
    }
    
    func testSectionInit() {
        let result = IndexPath(section: Constants.TestingValues.section)
        XCTAssertEqual(result, Constants.Expected.indexPathFromSectionInit)
    }
}
