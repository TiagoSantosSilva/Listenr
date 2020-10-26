//
//  AlbumDetailsCoordinator.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import CoreKit
import UIKit

final class AlbumDetailsCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let album: Album
    private let dependencies: DependencyContainable
    private let navigator: Navigatable
    
    // MARK: - Initialization
    
    init(album: Album, dependencies: DependencyContainable, navigator: Navigatable) {
        self.album = album
        self.dependencies = dependencies
        self.navigator = navigator
    }
    
    // MARK: - Functions
    
    func start() {
        let viewModel = AlbumDetailsViewModel(album: album, dependencies: dependencies)
        let viewController = AlbumDetailsViewController(viewModel: viewModel)
        navigator.transition(to: viewController, as: .push)
    }
}
