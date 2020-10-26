//
//  AlbumListViewModelMock.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
import Foundation
@testable import Listenr

final class AlbumListViewModelMock: AlbumListViewModelable {
    
    // MARK: - Properties
    
    var selectedTag: ChartTopTag = .init(name: "Hip-Hop")
    var albums: [Album?] = []
    var delegate: AlbumListViewModelDelegate?
    
    // MARK: - Initialization
    
    init() {
        self.albums = StubReader.read(contentOf: .albumList, type: AlbumResult.self).values.albums
    }
    
    init(loader: AlbumListLoadable, queue: DispatchQueue) { }
    
    // MARK: - Functions
    
    func loadAlbums(at indexPath: IndexPath) {
        
    }
    
    func reloadData(for tag: ChartTopTag) {
        
    }
}
