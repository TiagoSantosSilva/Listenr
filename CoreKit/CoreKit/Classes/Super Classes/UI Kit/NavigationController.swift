//
//  NavigationController.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

public final class NavigationController: UINavigationController {
    
    // MARK: - Initialization
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setupController()
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupController()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(UIKitError.unavailableXIB)
    }
    
    // MARK: - Setups
    
    private func setupController() {
        navigationBar.tintColor = .systemOrange
    }
}
