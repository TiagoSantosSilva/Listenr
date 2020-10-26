//
//  LoadingView+Layouter.swift
//  CoreKit
//
//  Created by Tiago Santos on 25/10/2020.
//

import UIKit

extension LoadingView {
    
    // MARK: - Functions
    
    func layout(activityIndicator: LoadingViewIndicator) {
        activityIndicator.center(axis: .vertical, to: self)
            .center(axis: .horizontal, to: self)
    }
}
