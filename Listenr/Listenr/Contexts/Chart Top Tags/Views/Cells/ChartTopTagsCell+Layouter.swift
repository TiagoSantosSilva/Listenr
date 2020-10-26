//
//  ChartTopTagsCell+Layouter.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import UIKit

extension ChartTopTagsCell {
    
    // MARK: - Constraints
    
    enum Constraints {
        enum NameLabel {
            static let leading: CGFloat = 8
            static let trailing: CGFloat = leading
        }
    }
    
    // MARK: - Functions
    
    func layout(nameLabel: UILabel) {
        nameLabel
            .pin(to: contentView, leading: Constraints.NameLabel.leading, trailing: Constraints.NameLabel.trailing)
            .center(axis: .vertical, to: contentView)
    }
}
