//
//  NetworkTypealiases.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import Foundation

public typealias NetworkCompletion<T: Decodable> = (_ result: Result<T, NetworkError>) -> Void
