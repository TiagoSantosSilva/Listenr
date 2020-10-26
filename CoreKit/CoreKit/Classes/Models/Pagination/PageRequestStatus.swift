//
//  PageRequestStatus.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
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

extension PageRequestStatus: Equatable {
    public static func ==(lhs: PageRequestStatus, rhs: PageRequestStatus) -> Bool {
        return lhs.page == rhs.page &&
            lhs.requestStatus == rhs.requestStatus
    }
}

public extension Array where Element: PageRequestStatus {
    func find(for page: Int) -> PageRequestStatus? {
        return first(where: { $0.page == page })
    }
}
