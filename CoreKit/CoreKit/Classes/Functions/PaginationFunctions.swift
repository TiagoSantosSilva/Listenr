//
//  PaginationFunctions.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
//

import Foundation

public typealias PaginatedLoadHandler = (_ page: Int) -> Void

public enum PaginationFunctions {
    
    // MARK: - Constants
    
    private enum Constants {
        static let firstPage: Int = 1
    }
    
    // MARK: - Perform load by page

    public static func performPaginatedLoadIfNeeded(
        at index: Int,
        itemsPerPage: Int?,
        expectedTotalItems: Int?,
        currentResults: inout [PageRequestStatus],
        loadHandler: @escaping PaginatedLoadHandler
    ) {
        guard let itemsPerPage = itemsPerPage else {
            currentResults = currentResults.filter { $0.page != Constants.firstPage }
            currentResults.append(PageRequestStatus(page: Constants.firstPage, requestStatus: .pending))
            loadHandler(Constants.firstPage)
            return
        }
        
        let maxPageToLoad: Int = {
            guard let expectedTotalItems = expectedTotalItems else {
                return Constants.firstPage
            }
            return Int((Double(expectedTotalItems) / Double(itemsPerPage)).rounded(.up))
        }()

        func shouldLoad(page: Int) -> Bool {
            guard page <= maxPageToLoad else {
                return false
            }
            guard let result = currentResults.first(where: { $0.page == page }) else {
                return true
            }
            return (result.requestStatus == .failed)
        }

        func pageNumber(for index: Int, itemsPerPage: Int) -> Int {
            return (index / itemsPerPage) + 1
        }

        [index, index + 5]
            .map { pageNumber(for: $0, itemsPerPage: itemsPerPage)  }
            .unique
            .filter { shouldLoad(page: $0) }
            .forEach { page in
                currentResults = currentResults.filter { $0.page != page }
                currentResults.append(PageRequestStatus(page: page, requestStatus: .pending))
                loadHandler(page)
            }
    }

    // MARK: - Item Assignment
    
    public static func assign<T>(
        items: [T],
        to list: inout [T],
        at page: Int,
        itemsPerPage: Int?
    ) {
        guard let itemsPerPage = itemsPerPage else { return }
        items
            .enumerated()
            .forEach { index, item in
                let index = (page - 1) * itemsPerPage + index
                guard index < list.count else { return }
                list[index] = item
        }
    }
    
    // MARK: - Index Path Creation
    
    public static func indexPaths(
        itemsPerPage: Int,
        itemCount: Int,
        page: Int,
        section: Int = 0
    ) -> [IndexPath] {
        let minIndex = (page - 1) * itemsPerPage
        let maxIndex = min(page * itemsPerPage, itemCount)
        guard maxIndex > minIndex else {
            return []
        }
        return (minIndex..<maxIndex).map { IndexPath(item: $0, section: section) }
    }
}
