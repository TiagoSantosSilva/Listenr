//
//  AlbumResult.swift
//  Listenr
//
//  Created by Tiago Silva on 24/10/2020.
//

import Foundation

struct AlbumResult: Decodable {
    let values: AlbumValues
    
    enum CodingKeys: String, CodingKey {
        case values = "albums"
    }
}

struct AlbumValues: Decodable {
    let albums: [Album]
    let attributes: AlbumResultAttributes
    
    enum CodingKeys: String, CodingKey {
        case albums = "album"
        case attributes = "@attr"
    }
}

struct Album: Decodable {
    let name: String
    let url: String
    let artist: Artist
    let image: AlbumImage?
    let attributes: AlbumAttributes
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case artist
        case image
        case attributes = "@attr"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.url = try values.decode(String.self, forKey: .url)
        self.artist = try values.decode(Artist.self, forKey: .artist)
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
        self.attributes = try values.decode(AlbumAttributes.self, forKey: .attributes)
    }
}

struct Artist: Decodable {
    let name: String
    let mbid: String
    let url: String
}

struct AlbumImage: Decodable {
    let url: URL?
    let size: Size

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let text = try values.decode(String.self, forKey: .text)
        self.url = URL(string: text)
        self.size = try values.decode(Size.self, forKey: .size)
    }
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

enum Size: String, Decodable, CaseIterable {
    case mega
    case extraLarge = "extralarge"
    case large
    case medium
    case small
    case none = ""
}

struct AlbumAttributes: Decodable {
    let rank: String
}

struct AlbumResultAttributes: Decodable {
    let tag: String
    let page: String
    let perPage: String
    let totalPages: String
    let total: String

    enum CodingKeys: String, CodingKey {
        case tag = "tag"
        case page = "page"
        case perPage = "perPage"
        case totalPages = "totalPages"
        case total = "total"
    }
}
