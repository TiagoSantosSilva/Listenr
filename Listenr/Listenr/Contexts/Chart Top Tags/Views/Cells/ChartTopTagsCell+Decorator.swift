//
//  ChartTopTagsCell+Decorator.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import UIKit

extension ChartTopTagsCell {
    
    // MARK: - Functions
    
    func decorate(nameLabel: UILabel) {
        contentView.backgroundColor = Color.cellGray
        
        nameLabel.numberOfLines = 2
    }
    
    func decorate(nameLabel: UILabel, isSelected: Bool) {
        let weight: UIFont.Weight = isSelected ? .bold : .regular
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: weight)
    }
}
