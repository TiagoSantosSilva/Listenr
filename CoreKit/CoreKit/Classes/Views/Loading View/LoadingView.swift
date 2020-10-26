//
//  LoadingView.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

public final class LoadingView: View {
    
    // MARK: - Subviews
    
    private let activityIndicator: LoadingViewIndicator = .init(style: .large)
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        addSubview(activityIndicator)
        layout(activityIndicator: activityIndicator)
        self.backgroundColor = Color.backgroundGray
    }
    
    // MARK: - Functions
    
    func appear() {
        self.activityIndicator.startAnimating()
    }
    
    func disappear() {
        hideWithFade {
            self.removeFromSuperview()
            self.activityIndicator.stopAnimating()
            self.alpha = 1.0
            self.isHidden = false
        }
    }
}
