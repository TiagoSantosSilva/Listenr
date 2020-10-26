//
//  Dictionary.swift
//  NetworkingKitTests
//
//  Created by Tiago Silva on 26/10/2020.
//

@testable import NetworkingKit
import XCTest

final class DictionaryTests: XCTestCase {
    
    // MARK: - Constants
    
    private enum Constants {
        enum TestingValues {
            static let initialDictionary: [String: String] = ["method": "json",
                                                              "key": "someKey",
                                                              "artist": "The 1975"]
            static let expectedDictionary: [(key: String, value: String)] = [(key: "artist", value: "The 1975"),
                                                                             (key: "key", value: "someKey"),
                                                                             (key: "method", value: "json")]
        }
    }
    
    // MARK: - Functions
    
    func testAscendedSortByKey() {
        let result = Constants.TestingValues.initialDictionary.ascendedSortByKey()
        let expected = Constants.TestingValues.expectedDictionary
        XCTAssertEqual(result.first!.key, expected.first!.key)
        XCTAssertEqual(result[1].key, expected[1].key)
        XCTAssertEqual(result[2].key, expected[2].key)
    }
}
