//
//  NetworkResponseParser.swift
//  NetworkingKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import Foundation
import os.log

public protocol NetworkResponseParseable: class {
    init()
    
    func parse<T: Decodable>(response: URLResponse?, data: Data?, completion: @escaping NetworkCompletion<T>)
}

public final class NetworkResponseParser: NetworkResponseParseable {
    
    // MARK: - Decoder
    
    private lazy var decoder: JSONDecoder = .init()
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Functions
    
    public func parse<T: Decodable>(response: URLResponse?, data: Data?, completion: @escaping NetworkCompletion<T>) {
        guard let response = response as? HTTPURLResponse, let data = data else {
            completion(.failure(.noData))
            return
        }
        
        switch result(for: response) {
        case .success:
            performParsingOfSuccessfulResponse(response: response, data: data, completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func performParsingOfSuccessfulResponse<T: Decodable>(response: HTTPURLResponse,
                                                                  data: Data,
                                                                  completion: @escaping NetworkCompletion<T>) {
        switch T.self {
        case is String.Type:
            guard let completion = completion as? NetworkCompletion<String> else { return }
            completion(.success(String(decoding: data, as: UTF8.self)))
        default:
            decode(data: data, completion: completion)
        }
    }
    
    // MARK: - Private Functions
    
    private func result(for response: HTTPURLResponse) -> Result<Void, NetworkError> {
        switch response.statusCode {
        case ResponseRanges.successful,
             ResponseRanges.created,
             ResponseRanges.accepted,
             ResponseRanges.reset,
             ResponseRanges.partialContent,
             ResponseRanges.multiStatus:
            return .success
        case ResponseRanges.noContent:
            return .failure(.noData)
        case ResponseRanges.authenticationError:
            return .failure(.sessionExpired)
        case ResponseRanges.clientError, ResponseRanges.serverError:
            return .failure(.requestFailed)
        case ResponseRanges.outdated:
            return .failure(.outdated)
        default:
            return .failure(.noData)
        }
    }
    
    private func decode<T: Decodable>(data: Data?, completion: @escaping NetworkCompletion<T>) {
        guard let data = data else {
            completion(.failure(.noData))
            return
        }

        do {
            let response = try decoder.decode(T.self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(.decodeFailed))
        }
    }
    
    // MARK: - Logging
    
    private func logData(_ data: Data?) {
        guard let data = data else { return }
        os_log("Response data ⛄️: %s", type: .info, String(decoding: data, as: UTF8.self))
    }
}
