//
//  PageRequestStatusTests.swift
//  CoreKitTests
//
//  Created by Tiago Silva on 26/10/2020.
//

@testable import CoreKit
import XCTest

final class PageRequestStatusTests: XCTestCase {
    
    // MARK: - Constants
    
    private enum Constants {
        enum TestingValues {
            static let statuses: [PageRequestStatus] = [.init(page: 0, requestStatus: .succeeded),
                                                        .init(page: 1, requestStatus: .pending),
                                                        .init(page: 2, requestStatus: .failed),
                                                        .init(page: 5, requestStatus: .succeeded)]
            
            static let existingPage: Int = 5
            static let nonExistingPage: Int = 4
            
            static let expectedStatusForExistingPage: PageRequestStatus = .init(page: existingPage, requestStatus: .succeeded)
        }
    }
    
    // MARK: - Functions
    
    func testFindWithResult() {
        XCTAssertNotNil(Constants.TestingValues.statuses.find(for: Constants.TestingValues.existingPage))
    }
    
    func testFindResultWithSuccess() {
        let result = Constants.TestingValues.statuses.find(for: Constants.TestingValues.existingPage)
        XCTAssertEqual(Constants.TestingValues.expectedStatusForExistingPage, result)
    }
    
    func testFindWithNoResult() {
        XCTAssertNil(Constants.TestingValues.statuses.find(for: Constants.TestingValues.nonExistingPage))
    }
}
