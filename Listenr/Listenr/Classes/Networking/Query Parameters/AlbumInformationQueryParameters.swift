//
//  AlbumInformationQueryParameters.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import Foundation

enum AlbumInformationQueryParameters {
    
    // MARK: - Keys
    
    private enum Keys {
        static let artist = "artist"
        static let album = "album"
    }
    
    // MARK: - Functions
    
    static func make(for album: Album) -> [URLQueryItem] {
        return [.init(name: Keys.album, value: album.name),
                .init(name: Keys.artist, value: album.artist.name)]
    }
}
