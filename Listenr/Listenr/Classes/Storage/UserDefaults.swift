//
//  UserDefaults.swift
//  CoreKit
//
//  Created by Tiago Silva on 26/10/2020.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Keys
    
    public enum UserDefaultsKey: String {
        case numberOfAppOpenings = "numberOfAppOpenings"
    }
    
    // MARK: - Functions
    
    public func set(_ key: UserDefaultsKey, value: Int) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    public func integer(forKey key: UserDefaultsKey) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
}
