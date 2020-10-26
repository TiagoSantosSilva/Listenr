//
//  AppDelegate.swift
//  Listenr
//
//  Created by Tiago Silva on 24/10/2020.
//

import CoreKit
import NetworkingKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    
    private let coordinator: AppCoordinator
    lazy var window: UIWindow? = .init(frame: UIScreen.main.bounds)
    
    // MARK: - Initialization
    
    override init() {
        let dependencies = DependencyContainer()
        let navigator = Navigator(navigationController: .init())
        self.coordinator = AppCoordinator(dependencies: dependencies, navigator: navigator)
        super.init()
    }

    // MARK: - UI Application Delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.makeKeyAndVisible()
        window?.rootViewController = coordinator.navigator.navigationController
        coordinator.start()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        StoreReviewManager.shared.askForReviewIfNeeded()
    }
}
