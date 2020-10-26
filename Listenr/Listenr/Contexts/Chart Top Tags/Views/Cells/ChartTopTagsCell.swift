//
//  ChartTopTagsCell.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import CoreKit
import UIKit

final class ChartTopTagsCell: CollectionViewCell {
    
    // MARK: - Subviews
    
    private let nameLabel: UILabel = .init()
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    // MARK: - Configuration
    
    func configure(with tag: ChartTopTag, isSelected: Bool) {
        self.nameLabel.text = tag.name
        decorate(nameLabel: nameLabel, isSelected: isSelected)
    }
    
    // MARK: - Functions
    
    private func setupCell() {
        contentView.addSubview(nameLabel)
        layout(nameLabel: nameLabel)
        decorate(nameLabel: nameLabel)
        roundCorners()
    }
}
