//
//  Endpoint.swift
//  Listenr
//
//  Created by Tiago Santos on 24/10/2020.
//

import Foundation
import NetworkingKit

extension Endpoint {
    static func albums(at page: Int, tag: ChartTopTag) -> Endpoint<AlbumResult> {
        let queryParameters: [URLQueryItem] = AlbumListQueryParameters.make(at: page, tag: tag)
        return .init(path: "tag.getTopAlbums",
                     queryParameters: queryParameters)
    }
    
    static func albumInformation(album: Album) -> Endpoint<AlbumInformationResult> {
        let queryParameters: [URLQueryItem] = AlbumInformationQueryParameters.make(for: album)
        return .init(path: "album.getInfo",
                     queryParameters: queryParameters)
    }
    
    static func chartTopTags() -> Endpoint<ChartTopTagResult> {
        return .init(path: "chart.getTopTags")
    }
}
