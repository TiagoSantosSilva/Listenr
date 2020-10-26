//
//  PageRequestStatus.swift
//  CoreKit
//
//  Created by Tiago Santos on 25/10/2020.
//

import Foundation

public final class PageRequestStatus {
    public let page: Int
    public var requestStatus: RequestStatus

    public init(page: Int, requestStatus: RequestStatus) {
        self.page = page
        self.requestStatus = requestStatus
    }
}

public extension Array where Element: PageRequestStatus {
    func find(for page: Int) -> PageRequestStatus? {
        return first(where: { $0.page == page })
    }
}
