//
//  String.swift
//  NetworkingKit
//
//  Created by Tiago Silva on 26/10/2020.
//

import Foundation

extension String {
    
    // MARK: - Properties
    
    static let empty = ""
    static let equals = "="
    
    // MARK: - Functions
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
