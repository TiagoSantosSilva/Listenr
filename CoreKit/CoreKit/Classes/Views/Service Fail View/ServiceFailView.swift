//
//  ServiceFailView.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

public final class ServiceFailView: View {
    
    // MARK: - Subviews
    
    private let stackView: UIStackView = .init()
    private let messageLabel: UILabel = .init()
    private let button: RoundableButton = .init(type: .system)
    
    // MARK: - Constants
    
    private enum Constants {
        static let message: String = "Something went wrong while loading your data."
        static let buttonTitle: String = "Try Again"
    }
    
    // MARK: - Properties
    
    var actionHandler: VoidCompletion?
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        addSubview(stackView)
        [messageLabel, button].forEach(stackView.addArrangedSubview)
        layout(stackView: stackView, button: button)
        decorate(stackView: stackView, messageLabel: messageLabel, button: button)
        setupTexts()
        button.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
    }
    
    private func setupTexts() {
        messageLabel.text = Constants.message
        button.setTitle(Constants.buttonTitle, for: .normal)
    }
    
    // MARK: - Selectors
    
    @objc private func buttonWasTapped(_ sender: UIButton) {
        actionHandler?()
    }
}
