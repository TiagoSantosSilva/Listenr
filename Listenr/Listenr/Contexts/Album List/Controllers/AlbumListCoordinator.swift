//
//  AlbumListCoordinator.swift
//  Listenr
//
//  Created by Tiago Silva on 24/10/2020.
//

import CoreKit
import UIKit

final class AlbumListCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let dependencies: DependencyContainable
    private let navigator: Navigatable
    private let viewController: AlbumListViewController
    
    // MARK: - Initialization
    
    init(dependencies: DependencyContainable, navigator: Navigatable) {
        self.dependencies = dependencies
        self.navigator = navigator
        let viewModel = AlbumListViewModel(loader: AlbumListLoader(dependencies: dependencies))
        self.viewController = AlbumListViewController(viewModel: viewModel)
        super.init()
        self.viewController.delegate = self
    }
    
    // MARK: - Functions
    
    func start() {
        navigator.transition(to: viewController, as: .root)
    }
}

// MARK: - Album List View Controller Delegate

extension AlbumListCoordinator: AlbumListViewControllerDelegate {
    func viewController(_ viewController: AlbumListViewController, didSelect album: Album) {
        initiate(coordinator: AlbumDetailsCoordinator(album: album, dependencies: dependencies, navigator: navigator))
    }
    
    func viewController(_ viewController: AlbumListViewController, didTapTagsButtonFor selectedTag: ChartTopTag) {
        let coordinator = ChartTopTagsCoordinator(dependencies: dependencies, navigator: navigator, selectedTag: selectedTag)
        coordinator.delegate = self
        initiate(coordinator: coordinator)
    }
}

// MARK: - Chart Top Tag Coordinator Delegate

extension AlbumListCoordinator: ChartTopTagsCoordinatorDelegate {
    func coordinator(_ coordinator: ChartTopTagsCoordinator, didSelect tag: ChartTopTag) {
        viewController.reload(for: tag)
    }
}
