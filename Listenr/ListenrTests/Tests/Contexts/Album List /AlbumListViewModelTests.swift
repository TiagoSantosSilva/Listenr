//
//  AlbumListViewModelTests.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
@testable import Listenr
import XCTest

final class AlbumListViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var loader: AlbumListLoaderMock!
    var viewModel: AlbumListViewModel!
    var albums: [Album]!
    var numberOfAlbums: Int!
    var delegateTarget: AlbumListViewModelDelegateTarget!
    
    // MARK: - Constants
    
    private enum Constants {
        enum TestingValues {
            static let secondTag: ChartTopTag = .init(name: "Rock")
            static let thirdTag: ChartTopTag = .init(name: "Alternative")
        }
        
        enum ExpectedValues {
            static let albumCountForTotalAlbumsLargerThanSetMaximum: Int = 1000
            static let numberOfDelegateCallsAfterFirstSuccessfulLoad: Int = 1
            static let numberOfDelegateCallsAfterSecondSuccessfulLoad: Int = 2
        }
    }
    
    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        delegateTarget = .init()
        loader = AlbumListLoaderMock()
        viewModel = AlbumListViewModel(loader: loader)
        viewModel.delegate = delegateTarget
        let result = StubReader.read(contentOf: .albumList, type: AlbumResult.self).values
        albums = result.albums
        numberOfAlbums = Int(result.attributes.total)
    }
    
    override func tearDown() {
        super.tearDown()
        albums = nil
        viewModel = nil
        loader = nil
        delegateTarget = nil
    }
    
    // MARK: - Tests
    
    func testTagChangeOnReload() {
        viewModel.reloadData(for: Constants.TestingValues.secondTag)
        XCTAssertEqual(viewModel.selectedTag, Constants.TestingValues.secondTag)
        
        viewModel.reloadData(for: Constants.TestingValues.thirdTag)
        XCTAssertEqual(viewModel.selectedTag, Constants.TestingValues.thirdTag)
    }
    
    func testAlbumLoad() {
        viewModel.loadAlbums(at: .zero)
        XCTAssertEqual(albums.count, viewModel.albums.filter { $0 != nil }.count)
    }
    
    func testAlbumCountIsSetToMaximumDefined() {
        viewModel.loadAlbums(at: .zero)
        XCTAssertTrue(numberOfAlbums > Constants.ExpectedValues.albumCountForTotalAlbumsLargerThanSetMaximum)
        XCTAssertEqual(viewModel.albums.count, Constants.ExpectedValues.albumCountForTotalAlbumsLargerThanSetMaximum)
    }
    
    func testReloadInformsDelegateForSuccessfulCall() {
        viewModel.loadAlbums(at: .zero)
        XCTAssertEqual(delegateTarget.numberOfSuccessfulCalls, Constants.ExpectedValues.numberOfDelegateCallsAfterFirstSuccessfulLoad)
        
        viewModel.reloadData(for: Constants.TestingValues.secondTag)
        XCTAssertEqual(delegateTarget.numberOfSuccessfulCalls, Constants.ExpectedValues.numberOfDelegateCallsAfterSecondSuccessfulLoad)
    }
}
