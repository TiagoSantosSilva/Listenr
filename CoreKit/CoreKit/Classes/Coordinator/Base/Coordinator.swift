//
//  Coordinator.swift
//  CoreKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import Foundation

public typealias Coordinator = CoordinatorClass & Coordinatable

public protocol CoordinatorDelegate: class {
    func coordinatorDidEnd(_ coordinator: Coordinator)
}

public protocol Coordinatable {
    func start()
}

open class CoordinatorClass: NSObject, CoordinatorDelegate {

    // MARK: - Public Properties

    public weak var coordinatorDelegate: CoordinatorDelegate?
    public lazy var coordinators: [Coordinator] = []

    // MARK: - Functions

    @discardableResult
    public func initiate(coordinator: Coordinator) -> Coordinator {
        coordinator.coordinatorDelegate = self
        coordinators.append(coordinator)
        coordinator.start()
        return coordinator
    }

    // MARK: - Coordinator Delegate

    public func coordinatorDidEnd(_ coordinator: Coordinator) {
        coordinators = coordinators.filter { $0 !== coordinator }
    }
}

