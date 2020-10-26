//
//  AlbumListDataSourceTests.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
@testable import Listenr
import XCTest

final class AlbumListDataSourceTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: AlbumListViewModelMock!
    var dataSource: AlbumListDataSource!
    var albums: [Album]!
    var collectionView: AlbumListCollectionView!
    
    // MARK: - Constants
    
    private enum Constants {
        static let section: Int = 0
        static let indexPath: IndexPath = .init(row: 0)
    }
    
    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        collectionView = AlbumListCollectionView(frame: .zero, collectionViewLayout: AlbumListCollectionViewLayout())
        viewModel = AlbumListViewModelMock()
        dataSource = AlbumListDataSource(viewModel: viewModel)
        albums = StubReader.read(contentOf: .albumList, type: AlbumResult.self).values.albums
    }
    
    override func tearDown() {
        super.tearDown()
        albums = nil
        dataSource = nil
        viewModel = nil
        collectionView = nil
    }
    
    // MARK: - Tests
    
    func testNumberOfItemsEqualToListCount() {
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: Constants.section), albums.count)
    }
    
    func testCellIsAlbumListCell() {
        let cell = dataSource.collectionView(collectionView, cellForItemAt: Constants.indexPath)
        XCTAssertTrue(cell is AlbumListCell)
    }
}
