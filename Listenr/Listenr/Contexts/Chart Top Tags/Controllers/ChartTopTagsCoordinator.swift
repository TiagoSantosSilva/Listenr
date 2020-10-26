//
//  ChartTopTagsCoordinator.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import CoreKit
import UIKit

protocol ChartTopTagsCoordinatorDelegate: class {
    func coordinator(_ coordinator: ChartTopTagsCoordinator, didSelect tag: ChartTopTag)
}

final class ChartTopTagsCoordinator: Coordinator {
    
    // MARK: - Delegate
    
    weak var delegate: ChartTopTagsCoordinatorDelegate?
    
    // MARK: - Properties
    
    private let dependencies: DependencyContainable
    private let navigator: Navigatable
    private let selectedTag: ChartTopTag
    
    // MARK: - Initialization
    
    init(dependencies: DependencyContainable, navigator: Navigatable, selectedTag: ChartTopTag) {
        self.dependencies = dependencies
        self.navigator = navigator
        self.selectedTag = selectedTag
    }
    
    // MARK: - Functions
    
    func start() {
        let viewModel = ChartTopTagsViewModel(dependencies: dependencies, selectedTag: selectedTag)
        let dataSource = ChartTopTagsDataSource(viewModel: viewModel)
        let viewController = ChartTopTagsViewController(dataSource: dataSource, viewModel: viewModel)
        viewController.delegate = self
        let navigationController = NavigationController(rootViewController: viewController)
        navigator.transition(to: navigationController, as: .modal)
    }
}

// MARK: - Chart Top Tags View Controller Delegate

extension ChartTopTagsCoordinator: ChartTopTagsViewControllerDelegate {
    func viewControllerDidTapCloseButton(_ viewController: ChartTopTagsViewController) {
        navigator.dismiss()
    }
    
    func viewController(_ viewController: ChartTopTagsViewController, didSelect tag: ChartTopTag) {
        delegate?.coordinator(self, didSelect: tag)
        navigator.dismiss()
    }
}
