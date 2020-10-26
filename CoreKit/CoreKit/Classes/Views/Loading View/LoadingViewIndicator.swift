//
//  LoadingViewIndicator.swift
//  CoreKit
//
//  Created by Tiago Santos on 25/10/2020.
//

import UIKit

final class LoadingViewIndicator: UIActivityIndicatorView {
    
    // MARK: - Initialization
    
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        setupIndicator()
    }
    
    required init(coder: NSCoder) {
        fatalError(UIKitError.unavailableXIB)
    }
    
    // MARK: - Setups
    
    private func setupIndicator() {
        self.color = .systemOrange
    }
}
