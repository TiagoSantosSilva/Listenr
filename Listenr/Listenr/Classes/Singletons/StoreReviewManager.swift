//
//  StoreReviewManager.swift
//  CoreKit
//
//  Created by Tiago Silva on 26/10/2020.
//

import Foundation
import StoreKit

final class StoreReviewManager {
    
    // MARK: - Shared Variable
    
    static var shared: StoreReviewManager = .init()
    
    // MARK: - Private Properties
    
    private let userDefaults: UserDefaults
    
    // MARK: - Constants
    
    private enum Constants {
        static let numberOfAppOpeningsToAskReview: Int = 10
        static let resetValue: Int = 0
    }
    
    // MARK: - Initialization
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    // MARK: - Functions
    
    func askForReviewIfNeeded() {
        let numberOfAppOpenings = userDefaults.integer(forKey: .numberOfAppOpenings)
        guard numberOfAppOpenings >= Constants.numberOfAppOpeningsToAskReview else {
            userDefaults.set(.numberOfAppOpenings, value: numberOfAppOpenings + 1)
            return
        }
        guard let windowScene = UIApplication.shared.windows.first?.windowScene else { return }
        SKStoreReviewController.requestReview(in: windowScene)
        userDefaults.set(.numberOfAppOpenings, value: Constants.resetValue)
    }
}

