//
//  AlbumListCell+Decorator.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import UIKit

extension AlbumListCell {
    
    // MARK: - Functions
    
    func decorate(imageView: UIImageView, nameLabel: UILabel) {
        decorate(imageView: imageView)
        decorate(nameLabel: nameLabel)
    }
    
    private func decorate(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Color.placeholderGray
    }
    
    private func decorate(nameLabel: UILabel) {
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
    }
}
