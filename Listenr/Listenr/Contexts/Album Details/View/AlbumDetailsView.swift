//
//  AlbumDetailsView.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import UIKit

final class AlbumDetailsView: View {
    
    // MARK: - Subviews
    
    private let imageView: UIImageView = .init()
    private let trackCountLabel: UILabel = .init()
    private let publishDateLabel: UILabel = .init()
    private let artistNameLabel: UILabel = .init()
    private let listenerCountLabel: UILabel = .init()
    private let scrollView: UIScrollView = .init()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // MARK: - Functions
    
    func configure(with information: AlbumInformation) {
        let viewModel = AlbumDetailsViewViewModel(information: information)
        imageView.kf.setImage(with: information.image?.url)
        trackCountLabel.text = viewModel.trackCount
        publishDateLabel.text = viewModel.publishDate
        artistNameLabel.text = viewModel.artistName
        listenerCountLabel.text = viewModel.listenerCount
    }
    
    // MARK: - Setups
    
    private func setupView() {
        addSubview(scrollView)
        [imageView, trackCountLabel, publishDateLabel, artistNameLabel, listenerCountLabel].forEach(scrollView.addSubview)
        layout(scrollView: scrollView,
               imageView: imageView,
               trackCountLabel: trackCountLabel,
               publishDateLabel: publishDateLabel,
               artistNameLabel: artistNameLabel,
               listenerCountLabel: listenerCountLabel)
        decorate(scrollView: scrollView,
                 imageView: imageView,
                 trackCountLabel: trackCountLabel,
                 publishDateLabel: publishDateLabel,
                 artistNameLabel: artistNameLabel,
                 listenerCountLabel: listenerCountLabel)
    }
}
