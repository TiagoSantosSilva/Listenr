//
//  Result.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import Foundation

extension Result where Success == Void {
    static var success: Result<Void, Failure> {
        return .success(Void())
    }
}
