//
//  AlbumDetailsViewModelTests.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
@testable import Listenr
import XCTest

final class AlbumDetailsViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var dependencies: DependencyContainerMock!
    var viewModel: AlbumDetailsViewModel!
    var networkProvider: NetworkProviderMock!
    var engine: NetworkEngineMock!
    var album: Album!
    var delegateTarget: AlbumDetailsViewModelDelegateTarget!
    
    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        engine = NetworkEngineMock()
        networkProvider = NetworkProviderMock(engine: engine)
        dependencies = DependencyContainerMock(networkProvider: networkProvider)
        let albums = StubReader.read(contentOf: .albumList, type: AlbumResult.self)
        album = albums.values.albums.first!
        viewModel = AlbumDetailsViewModel(album: album, dependencies: dependencies)
        delegateTarget = AlbumDetailsViewModelDelegateTarget()
        viewModel.delegate = delegateTarget
    }
    
    override func tearDown() {
        delegateTarget = nil
        viewModel = nil
        album = nil
        dependencies = nil
        networkProvider = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testAlbumName() {
        XCTAssertEqual(album.name, viewModel.albumName)
    }
    
    func dontTestSuccessfulServiceCall() {
        let informationResult = StubReader.read(contentOf: .albumInformation, type: AlbumInformationResult.self)
        engine.result = AnyDecodable(informationResult.information)
        engine.resultType = .success(())
        viewModel.loadDetails()
        XCTAssertEqual(informationResult.information, viewModel.information!)
        XCTAssertEqual(delegateTarget.numberOfSuccessfulCalls, 1)
    }
    
    func dontTestFailedServiceCall() {
        engine.resultType = .failure(.noData)
        viewModel.loadDetails()
        XCTAssertNil(viewModel.information)
        XCTAssertEqual(delegateTarget.numberOfFailedCalls, 1)
    }
}
