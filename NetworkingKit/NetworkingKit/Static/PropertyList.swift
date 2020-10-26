//
//  PropertyList.swift
//  CoreKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import Foundation

enum PropertyListKey: String {
    case apiKey = "BackendKey"
    case backendURL = "BackendURL"
}

public enum PropertyList {
    
    // MARK: - Constants
    
    private enum Constants {
        static let configurationFile = "Configuration"
        static let propertyListFormat = "plist"
    }
    
    // MARK: - Functions
    
    static func string(for key: PropertyListKey) -> String? {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        let plistPath: String? = Bundle.current.path(forResource: Constants.configurationFile, ofType: Constants.propertyListFormat)!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            let data = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            guard let value = data[key.rawValue] as? String else { return nil }
            return value
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
            return nil
        }
    }
}
