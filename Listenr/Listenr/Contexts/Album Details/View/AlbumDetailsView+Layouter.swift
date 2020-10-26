//
//  AlbumDetailsView+Layouter.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import UIKit

extension AlbumDetailsView {
    
    // MARK: - Constraints
    
    enum Constraints {
        enum ImageView {
            static let top: CGFloat = 16
            static let width: CGFloat = 250
            static let height: CGFloat = width
        }
        
        enum TrackCount {
            static let top: CGFloat = 24
            static let leading: CGFloat = 16
            static let trailing: CGFloat = leading
        }
        
        enum MiddleLabel {
            static let top: CGFloat = 12
            static let leading: CGFloat = 0
            static let trailing: CGFloat = leading
        }
        
        enum ListenerCountLabel {
            static let top: CGFloat = 12
            static let leading: CGFloat = 0
            static let trailing: CGFloat = leading
            static let bottom: CGFloat = 16
        }
    }
    
    // MARK: - Functions
    
    func layout(scrollView: UIScrollView,
                imageView: UIImageView,
                trackCountLabel: UILabel,
                publishDateLabel: UILabel,
                artistNameLabel: UILabel,
                listenerCountLabel: UILabel) {
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        layout(frameGuide: frameGuide, contentGuide: contentGuide, scrollView: scrollView)
        layout(imageView: imageView, contentGuide: contentGuide)
        layout(trackCountLabel: trackCountLabel, imageView: imageView, contentGuide: contentGuide)
        layout(publishDateLabel: publishDateLabel, trackCountLabel: trackCountLabel)
        layout(artistNameLabel: artistNameLabel, publishDateLabel: publishDateLabel)
        layout(listenerCountLabel: listenerCountLabel, artistNameLabel: artistNameLabel, contentGuide: contentGuide)
    }
    
    private func layout(frameGuide: UILayoutGuide, contentGuide: UILayoutGuide, scrollView: UIScrollView) {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        frameGuide.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        frameGuide.topAnchor.constraint(equalTo: topAnchor).isActive = true
        frameGuide.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        frameGuide.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        frameGuide.widthAnchor.constraint(equalTo: contentGuide.widthAnchor).isActive = true
    }
    
    private func layout(imageView: UIImageView, contentGuide: UILayoutGuide) {
        imageView.pin(to: contentGuide, top: Constraints.ImageView.top)
            .constraint(width: Constraints.ImageView.width)
            .constraint(height: Constraints.ImageView.height)
            .center(axis: .horizontal, to: contentGuide)
    }
    
    private func layout(trackCountLabel: UILabel, imageView: UIImageView, contentGuide: UILayoutGuide) {
        trackCountLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constraints.TrackCount.top).isActive = true
        trackCountLabel.pin(to: contentGuide,
                            leading: Constraints.TrackCount.leading,
                            trailing: Constraints.TrackCount.trailing)
    }
    
    private func layout(publishDateLabel: UILabel, trackCountLabel: UILabel) {
        publishDateLabel.topAnchor.constraint(equalTo: trackCountLabel.bottomAnchor, constant: Constraints.MiddleLabel.top).isActive = true
        publishDateLabel.pin(to: trackCountLabel,
                             leading: Constraints.MiddleLabel.leading,
                             trailing: Constraints.MiddleLabel.trailing)
    }
    
    private func layout(artistNameLabel: UILabel, publishDateLabel: UILabel) {
        artistNameLabel.topAnchor.constraint(equalTo: publishDateLabel.bottomAnchor, constant: Constraints.MiddleLabel.top).isActive = true
        artistNameLabel.pin(to: publishDateLabel,
                            leading: Constraints.MiddleLabel.leading,
                            trailing: Constraints.MiddleLabel.trailing)
    }
    
    private func layout(listenerCountLabel: UILabel, artistNameLabel: UILabel, contentGuide: UILayoutGuide) {
        listenerCountLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: Constraints.ListenerCountLabel.top).isActive = true
        listenerCountLabel.pin(to: artistNameLabel,
                               leading: Constraints.ListenerCountLabel.leading,
                               trailing: Constraints.ListenerCountLabel.trailing)
        listenerCountLabel.pin(to: contentGuide, bottom: Constraints.ListenerCountLabel.bottom)
    }
}
