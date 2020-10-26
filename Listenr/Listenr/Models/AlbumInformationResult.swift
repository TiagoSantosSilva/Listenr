//
//  AlbumInformationResult.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import Foundation

struct AlbumInformationResult: Decodable {
    let information: AlbumInformation
    
    enum CodingKeys: String, CodingKey {
        case information = "album"
    }
}

struct AlbumInformation: Decodable {
    
    // MARK: - Properties
    
    let name: String
    let artist: String
    let url: String
    let image: AlbumImage?
    let listeners: String
    let playCount: String
    let tracks: [Track]
    
    // MARK: - Initialization
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.artist = try values.decode(String.self, forKey: .artist)
        self.url = try values.decode(String.self, forKey: .url)
        let images = try values.decode([AlbumImage].self, forKey: .image)
        let imageToUse: AlbumImage? = {
            let sizes: [Size] = [.mega, .extraLarge, .large, .medium, .small, .none]
            for a in sizes {
                if let image = images.first(where: { $0.size == a }) {
                    return image
                }
            }
            return nil
        }()
        self.image = imageToUse
        self.listeners = try values.decode(String.self, forKey: .listeners)
        self.playCount = try values.decode(String.self, forKey: .playCount)
        let tracksList = try values.decode(Tracks.self, forKey: .tracks)
        self.tracks = tracksList.tracks
    }
    
    // MARK: - Coding Kys
    
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case url
        case image
        case listeners
        case playCount = "playcount"
        case tracks
    }
}

struct Tracks: Codable {
    let tracks: [Track]

    enum CodingKeys: String, CodingKey {
        case tracks = "track"
    }
}

// MARK: - Track
struct Track: Codable {
    let name: String
}
