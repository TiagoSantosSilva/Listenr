//
//  AppCoordinator.swift
//  Listenr
//
//  Created by Tiago Silva on 24/10/2020.
//

import CoreKit
import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Dependencies
    
    let navigator: Navigatable
    private let dependencies: DependencyContainable
    
    // MARK: - Initialization
    
    init(dependencies: DependencyContainable, navigator: Navigatable) {
        self.dependencies = dependencies
        self.navigator = navigator
    }
    
    // MARK: - Start
    
    func start() {
        initiate(coordinator: AlbumListCoordinator(dependencies: dependencies, navigator: navigator))
    }
}
