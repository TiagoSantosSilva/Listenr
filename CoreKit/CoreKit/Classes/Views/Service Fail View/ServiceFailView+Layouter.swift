//
//  ServiceFailView+Layouter.swift
//  CoreKit
//
//  Created by Tiago Santos on 25/10/2020.
//

import UIKit

extension ServiceFailView {
    
    // MARK: - Constants
    
    private enum Constants {
        enum StackView {
            static let top: CGFloat = 16
            static let leading: CGFloat = top
            static let trailing: CGFloat = top
            static let bottom: CGFloat = top
        }
    }
    
    // MARK: - Functions
    
    func layout(stackView: UIStackView, button: UIButton) {
        stackView
            .center(axis: .vertical, to: self)
            .center(axis: .horizontal, to: self)
        stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: Constants.StackView.top).isActive = true
        stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: Constants.StackView.leading).isActive = true
        stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -Constants.StackView.trailing).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -Constants.StackView.bottom).isActive = true
        
        button.constraint(height: 48)
    }
}
