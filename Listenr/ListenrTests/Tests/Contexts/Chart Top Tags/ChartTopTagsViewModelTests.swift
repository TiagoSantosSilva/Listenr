//
//  ChartTopTagsViewModelTests.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
@testable import Listenr
import XCTest

final class ChartTopTagsViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: ChartTopTagsViewModel!
    var dependencies: DependencyContainerMock!
    var tags: [ChartTopTag]!
    var delegateTarget: ChartTopTagsViewModelDelegateTarget!
    var networkProvider: NetworkProviderMock!
    var engine: NetworkEngineMock!
    
    // MARK: - Constants
    
    private enum Constants {
        enum TestingValues {
            static let firstTag: ChartTopTag = .init(name: "Rock")
            static let secondTag: ChartTopTag = .init(name: "Alternative")
            
            static let searchedTerm: String = "Hip"
        }
    }
    
    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        engine = NetworkEngineMock()
        networkProvider = NetworkProviderMock(engine: engine)
        dependencies = DependencyContainerMock(networkProvider: networkProvider)
        delegateTarget = .init()
        viewModel = ChartTopTagsViewModel(dependencies: dependencies, selectedTag: Constants.TestingValues.firstTag)
        tags = StubReader.read(contentOf: .chartTopTags, type: ChartTopTagResult.self).values.tags
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        dependencies = nil
        delegateTarget = nil
        networkProvider = nil
        engine = nil
        tags = nil
    }
    
    // MARK: - Tests
    
    func testIsTagSelectedReturnsFalseForDifferentTag() {
        XCTAssertTrue(viewModel.isTagSelected(tag: Constants.TestingValues.firstTag))
    }
    
    func testIsTagSelectedReturnsTrueForSameTag() {
        XCTAssertFalse(viewModel.isTagSelected(tag: Constants.TestingValues.secondTag))
    }
    
    func dontTestSuccessfulServiceCall() {
        let loadedTags = StubReader.read(contentOf: .chartTopTags, type: ChartTopTagResult.self).values.tags
        engine.result = AnyDecodable(loadedTags)
        engine.resultType = .success(())
        viewModel.loadTopTags()
        XCTAssertEqual(loadedTags.count, tags.count)
        XCTAssertEqual(delegateTarget.numberOfSuccessfulCalls, 1)
    }
    
    func dontTestFailedServiceCall() {
        engine.resultType = .failure(.noData)
        viewModel.loadTopTags()
        XCTAssertTrue(viewModel.tags.isEmpty)
        XCTAssertEqual(delegateTarget.numberOfFailedCalls, 1)
    }
    
    func dontTextTagListSearch() {
        let loadedTags = StubReader.read(contentOf: .chartTopTags, type: ChartTopTagResult.self).values.tags
        engine.result = AnyDecodable(loadedTags)
        engine.resultType = .success(())
        viewModel.loadTopTags()
        viewModel.updateChartList(for: Constants.TestingValues.searchedTerm)
        let filteredTags = tags.filter { $0.name.localizedCaseInsensitiveContains(Constants.TestingValues.searchedTerm) }
        XCTAssertEqual(filteredTags.count, viewModel.tags.count)
    }
}
