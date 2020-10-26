//
//  AlbumListCell+Layouter.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

extension AlbumListCell {
    
    // MARK: - Constraints
    
    private enum Constraints {
        enum ImageView {
            static let top: CGFloat = 0
            static let leading: CGFloat = 0
            static let trailing: CGFloat = leading
            static let height: CGFloat = 150
        }
        
        enum NameLabel {
            static let top: CGFloat = 4
            static let leading: CGFloat = 0
            static let trailing: CGFloat = leading
            static let bottom: CGFloat = 0
        }
    }
    
    // MARK: - Functions
    
    func layout(imageView: UIImageView, nameLabel: UILabel) {
        layout(imageView: imageView)
        layout(nameLabel: nameLabel, imageView: imageView)
    }
    
    private func layout(imageView: UIImageView) {
        imageView.pin(to: contentView,
                      top: Constraints.ImageView.top,
                      leading: Constraints.ImageView.leading,
                      trailing: Constraints.ImageView.trailing)
            .constraint(height: Constraints.ImageView.height)
    }
    
    private func layout(nameLabel: UILabel, imageView: UIImageView) {
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constraints.NameLabel.top).isActive = true
        nameLabel.pin(to: imageView,
                      leading: Constraints.NameLabel.leading,
                      trailing: Constraints.NameLabel.trailing)
            .pin(to: contentView, bottom: Constraints.NameLabel.bottom)
    }
}
