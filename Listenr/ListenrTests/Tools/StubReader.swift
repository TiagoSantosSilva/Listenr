//
//  StubReader.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import Foundation

enum FileExtensions {
    static let json = "json"
}

final class StubBundleFindingClass {}

enum StubReader {
    // swiftlint:disable force_try
    static func read<T: Decodable>(contentOf contentType: StubbedContent, type: T.Type) -> T {
        let path = Bundle(for: StubBundleFindingClass.self).url(forResource: contentType.rawValue, withExtension: FileExtensions.json)!
        let jsonData = try! Data(contentsOf: path, options: .mappedIfSafe)
        let jsonResult = try! JSONDecoder().decode(T.self, from: jsonData)
        return jsonResult
    }
}
