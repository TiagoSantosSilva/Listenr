//
//  AlbumListViewModelDelegateTarget.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
import Foundation
@testable import Listenr

final class AlbumListViewModelDelegateTarget: AlbumListViewModelDelegate {
    
    // MARK: - Properties
    
    var numberOfSuccessfulCalls: Int = 0
    
    // MARK: - Functions
    
    func viewModelDidLoadFirstAlbumBatch(_ viewModel: AlbumListViewModel) {
        numberOfSuccessfulCalls += 1
    }
    
    func viewModelDidFailServiceCall(_ viewModel: Any, handler: @escaping VoidCompletion) {
        return
    }
    
    func viewModel(_ viewModel: AlbumListViewModel, didLoadAlbumsAt indexPaths: [IndexPath]) {
        return
    }
}
