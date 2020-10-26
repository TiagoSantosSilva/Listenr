//
//  AlbumListLoaderMock.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
import Foundation
@testable import Listenr

final class AlbumListLoaderMock: AlbumListLoadable {
    
    init() {}
    init(dependencies: DependencyContainable) {}
    
    func loadAlbums(at index: Int, tag: ChartTopTag, completion: @escaping AlbumListLoadCompletion) {
        completion(.success(StubReader.read(contentOf: .albumList, type: AlbumResult.self).values))
    }
}
