//
//  AlbumDetailsView+Decorator.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import UIKit

extension AlbumDetailsView {
    
    // MARK: - Functions
    
    func decorate(scrollView: UIScrollView,
                  imageView: UIImageView,
                  trackCountLabel: UILabel,
                  publishDateLabel: UILabel,
                  artistNameLabel: UILabel,
                  listenerCountLabel: UILabel) {
        decorate()
        decorate(scrollView: scrollView)
        decorate(imageView: imageView)
        decorate(trackCountLabel: trackCountLabel,
                 publishDateLabel: publishDateLabel,
                 artistNameLabel: artistNameLabel,
                 listenerCountLabel: listenerCountLabel)
    }
    
    private func decorate() {
        self.backgroundColor = Color.backgroundGray
    }
    
    private func decorate(scrollView: UIScrollView) {
        scrollView.alwaysBounceVertical = true
    }
    
    private func decorate(imageView: UIImageView) {
        imageView.backgroundColor = Color.placeholderGray
        imageView.contentMode = .scaleAspectFit
    }
    
    private func decorate(trackCountLabel: UILabel,
                          publishDateLabel: UILabel,
                          artistNameLabel: UILabel,
                          listenerCountLabel: UILabel) {
        [trackCountLabel, publishDateLabel, artistNameLabel, listenerCountLabel].forEach {
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
}
