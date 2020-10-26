//
//  ServiceFailView+Decorator.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

extension ServiceFailView {
    
    // MARK: - Functions
    
    func decorate(stackView: UIStackView, messageLabel: UILabel, button: RoundableButton) {
        decorate()
        decorate(stackView: stackView)
        decorate(messageLabel: messageLabel)
        decorate(button: button)
    }
    
    private func decorate() {
        self.backgroundColor = Color.backgroundGray
    }
    
    private func decorate(stackView: UIStackView) {
        stackView.spacing = 24
        stackView.axis = .vertical
    }
    
    private func decorate(messageLabel: UILabel) {
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
    }
    
    private func decorate(button: RoundableButton) {
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 4
    }
}
