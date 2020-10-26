//
//  AlbumListCell.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import CoreKit
import Kingfisher
import UIKit

final class AlbumListCell: CollectionViewCell {
    
    // MARK: - Subviews
    
    private let imageView: UIImageView = .init()
    private let nameLabel: UILabel = .init()
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.imageView.kf.cancelDownloadTask()
        self.imageView.image = nil
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    // MARK: - Functions
    
    func configure(with album: Album) {
        self.nameLabel.text = album.name
        self.imageView.kf.setImage(with: album.image?.url)
    }
    
    // MARK: - Setups
    
    private func setupCell() {
        [imageView, nameLabel].forEach(contentView.addSubview)
        layout(imageView: imageView, nameLabel: nameLabel)
        decorate(imageView: imageView, nameLabel: nameLabel)
    }
}
