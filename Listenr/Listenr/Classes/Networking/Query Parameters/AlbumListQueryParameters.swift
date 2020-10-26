//
//  AlbumListQueryParameters.swift
//  Listenr
//
//  Created by Tiago Silva on 24/10/2020.
//

import CoreKit
import Foundation

enum AlbumListQueryParameters {
    
    // MARK: - Functions
    
    static func make(at page: Int, tag: ChartTopTag) -> [URLQueryItem] {
        return [.init(name: QueryParamaterKeys.tag, value: tag.name),
                .init(name: QueryParamaterKeys.page, value: String(describing: page))]
    }
}
