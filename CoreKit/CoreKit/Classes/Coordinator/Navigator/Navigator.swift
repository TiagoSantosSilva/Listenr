//
//  Navigator.swift
//  CoreKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import UIKit

public protocol Navigatable {
    var navigationController: NavigationController { get }
    
    init(navigationController: NavigationController)
    
    func dismiss()
    func transition(to viewController: UIViewController, as transitionType: NavigatorTransition, animated: Bool)
}

public extension Navigatable {
    func transition(to viewController: UIViewController, as transitionType: NavigatorTransition) {
        transition(to: viewController, as: transitionType, animated: true)
    }
}

public final class Navigator: Navigatable {
    
    // MARK: - Navigation Controller
    
    public let navigationController: NavigationController
    
    // MARK: - Initialization
    
    public init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Functions
    
    public func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    public func transition(to viewController: UIViewController, as transitionType: NavigatorTransition, animated: Bool) {
        switch transitionType {
        case .root:
            navigationController.setViewControllers([viewController], animated: animated)
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .modal:
            navigationController.present(viewController, animated: animated, completion: nil)
        }
    }
}

