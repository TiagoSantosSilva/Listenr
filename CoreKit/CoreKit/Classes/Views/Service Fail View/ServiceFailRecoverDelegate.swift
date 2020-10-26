//
//  ServiceFailRecoverDelegate.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

public protocol ServiceFailRecoverDelegate: class {
    func viewModelDidFailServiceCall(_ viewModel: Any, handler: @escaping VoidCompletion)
}

public extension ServiceFailRecoverDelegate where Self: ViewController {
    func viewModelDidFailServiceCall(_ viewModel: Any, handler: @escaping VoidCompletion) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.serviceFailView.actionHandler = { [weak self] in
                guard let self = self else { return }
                self.remove(subView: self.serviceFailView)
                handler()
            }
            self.view.addAndConstraintToAllFrame(childView: self.serviceFailView)
        }
    }
}
