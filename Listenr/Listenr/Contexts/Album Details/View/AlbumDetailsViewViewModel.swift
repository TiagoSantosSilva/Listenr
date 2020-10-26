//
//  AlbumDetailsViewViewModel.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import Foundation

struct AlbumDetailsViewViewModel {
    
    // MARK: - Properties
    
    let trackCount: String
    let publishDate: String
    let artistName: String
    let listenerCount: String
    
    // MARK: - Initialization
    
    init(information: AlbumInformation) {
        self.trackCount = {
            guard information.tracks.count != 1 else {
                return "\(information.tracks.count) track"
            }
            return "\(information.tracks.count) tracks"
        }()
        self.publishDate = "N/A"
        self.artistName = information.artist
        self.listenerCount = {
            guard information.listeners != "1" else {
                return "\(information.listeners) listener"
            }
            return "\(information.listeners) listeners"
        }()
    }
}
