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
    
    static func string(for key: PropertyListKey) -> String? {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        let plistPath: String? = Bundle(identifier: "com.TiagoSilva.NetworkingKit")!.path(forResource: "Configuration", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            let data = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            guard let value = data[key.rawValue] as? String else { return nil }
            return value
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
            return nil
        }
    }
}
