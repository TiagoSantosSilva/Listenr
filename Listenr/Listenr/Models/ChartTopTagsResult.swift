//
//  ChartTopTagsResult.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import Foundation

struct ChartTopTagResult: Decodable {
    let values: ChartTopTagValues

    enum CodingKeys: String, CodingKey {
        case values = "tags"
    }
}

struct ChartTopTagValues: Decodable {
    let tags: [ChartTopTag]

    enum CodingKeys: String, CodingKey {
        case tags = "tag"
    }
}

struct ChartTopTag: Decodable {
    let name: String
}

extension ChartTopTag: Equatable {
    static func ==(lhs: ChartTopTag, rhs: ChartTopTag) -> Bool {
        return lhs.name == rhs.name
    }
}
