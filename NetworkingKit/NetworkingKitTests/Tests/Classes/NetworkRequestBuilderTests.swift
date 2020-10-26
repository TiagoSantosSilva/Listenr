//
//  NetworkRequestBuilderTests.swift
//  NetworkingKitTests
//
//  Created by Tiago Silva on 26/10/2020.
//

@testable import NetworkingKit
import XCTest

final class NetworkRequestBuilderTests: XCTestCase {
    
    // MARK: - Properties
    
    private var builder: NetworkRequestBuilder!
    
    // MARK: - Constants
    
    private enum Constants {
        static let base: String = "https://www.apibase.com/v1/"
        static let method: HTTPMethod = .get
        static let path: String = "tests"
        static let firstQueryItem: URLQueryItem = .init(name: "FirstKey", value: "First Value")
        static let secondQueryItem: URLQueryItem = .init(name: "SecondKey", value: "Second Value")
        static let jsonQueryItem: URLQueryItem = .init(name: "format", value: "json")
        static let queryParameters: [URLQueryItem] = [firstQueryItem, secondQueryItem]
        static let endpoint: Endpoint<String> = .init(base: base,
                                                      method: .get,
                                                      path: "tests",
                                                      queryParameters: queryParameters)
    }
    
    
    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        builder = .init(queryParameterBuilder: NetworkRequestQueryParameterBuilder())
    }
    
    override func tearDown() {
        builder = nil
        super.tearDown()
    }
    
    // MARK: - Functions
    
    func testBuildSetsHTTPMethod() {
        let request = try! builder.build(endpoint: Constants.endpoint)
        XCTAssertEqual(request.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testBuildSetsQueryParameters() {
        let request = try! builder.build(endpoint: Constants.endpoint)
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!
        XCTAssertTrue(components.queryItems!.contains(where: { $0.name == Constants.firstQueryItem.name }))
        XCTAssertTrue(components.queryItems!.contains(where: { $0.name == Constants.secondQueryItem.name }))
    }
    
    func testBuildSetsFormatQueryParameter() {
        let request = try! builder.build(endpoint: Constants.endpoint)
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!
        XCTAssertTrue(components.queryItems!.contains(where: { $0.name == Constants.jsonQueryItem.name }))
        XCTAssertTrue(components.queryItems!.contains(where: { $0.value == Constants.jsonQueryItem.value }))
    }
}
