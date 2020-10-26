//
//  DiskProvider.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 26/10/2020.
//

import Foundation
import os.log

public protocol DiskProvidable: class {
    func read(request: URLRequest, isOnline: Bool) -> Data?
    func save(request: URLRequest, with data: Data)
}

public final class DiskProvider: DiskProvidable {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cacheValidityInSeconds: Int = 3600
    }
    
    // MARK: - Encoder & Decoder
    
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Functions
    
    public func read(request: URLRequest, isOnline: Bool) -> Data? {
        guard let queryItems = queryItems(for: request),
              let fileURL = filePath(for: queryItems) else { return nil }
        do {
            print("Is online: \(isOnline) 🇵🇹🇵🇹🇵🇹")
            let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            let wrappedData = try decoder.decode(DiskWrappedData.self, from: data)
            
            guard isOnline else { return wrappedData.data }
            guard shouldRead(for: wrappedData) else { return nil }
            return wrappedData.data
        } catch {
            os_log("%s", error.localizedDescription)
            return nil
        }
    }
    
    public func save(request: URLRequest, with data: Data) {
        guard let queryItems = queryItems(for: request),
              let fileURL = filePath(for: queryItems) else { return }
        do {
            let wrappedData = DiskWrappedData(data: data)
            let encodedData = try encoder.encode(wrappedData)
            try encodedData.write(to: fileURL, options: .atomic)
        } catch {
            os_log("%s", error.localizedDescription)
        }
    }
    
    // MARK: - Private Functions
    
    private func queryItems(for request: URLRequest) -> [URLQueryItem]? {
        guard let url = request.url,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else { return nil }
        let sortedQueryItems = queryItems.sorted(by: { $0.name < $1.name })
        return sortedQueryItems
    }
    
    private func shouldRead(for data: DiskWrappedData) -> Bool {
        let writtenTime = data.creationTime
        let currentTime = Int(Date().timeIntervalSince1970)
        let should = (currentTime - writtenTime) <= Constants.cacheValidityInSeconds
        return should
    }
    
    private func filePath(for queryItems: [URLQueryItem]) -> URL? {
        var string: String = .empty
        queryItems.forEach {
            string.append($0.name
                            .appending(String.equals)
                            .appending($0.value ?? String.empty))
        }
        let fileName = string.toBase64()
        guard let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last else { return nil }
        let fileURL = directory.appendingPathComponent(fileName)
        return fileURL
    }
}
