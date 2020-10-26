//
//  NetworkResponseRanges.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import Foundation

enum ResponseRanges {
    static let successful = 200
    static let created = 201
    static let accepted = 202
    static let nonAuthorized = 203
    static let noContent = 204
    static let reset = 205
    static let partialContent = 206
    static let multiStatus = 207
    static let authenticationError = 401
    static let clientError = 402...500
    static let serverError = 501...599
    static let outdated = 600
}
