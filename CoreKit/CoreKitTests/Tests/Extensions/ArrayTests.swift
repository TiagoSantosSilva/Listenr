//
//  ArrayTests.swift
//  CoreKitTests
//
//  Created by Tiago Silva on 26/10/2020.
//

@testable import CoreKit
import XCTest

final class ArrayTests: XCTestCase {
    
    // MARK: - Constants
    
    private enum Constants {
        enum TestingValues {
            static let initialArray: [Int] = [1, 2, 3, 4, 1, 2, 6, 9, 9]
            static let expectedArray: [Int] = [1, 2, 3, 4, 6, 9]
        }
    }
    
    // MARK: - Functions
    
    func testUnique() {
        let result = Constants.TestingValues.initialArray.unique
        XCTAssertEqual(result.count, Constants.TestingValues.expectedArray.count)
    }
}
