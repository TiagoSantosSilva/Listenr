//
//  AlbumDetailsViewModelDelegateTarget.swift
//  ListenrTests
//
//  Created by Tiago Silva on 26/10/2020.
//

import CoreKit
import Foundation
@testable import Listenr

final class AlbumDetailsViewModelDelegateTarget: AlbumDetailsViewModelDelegate {
    
    // MARK: - Properties
    
    var numberOfSuccessfulCalls: Int = 0
    var numberOfFailedCalls: Int = 0
    
    func viewModel(_ viewModel: AlbumDetailsViewModel, didLoad details: AlbumInformation) {
        numberOfSuccessfulCalls += 1
    }
    
    func viewModelDidFailServiceCall(_ viewModel: Any, handler: @escaping VoidCompletion) {
        numberOfFailedCalls += 1
    }
}
