//
//  AlbumDetailsViewController.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import CoreKit
import UIKit

final class AlbumDetailsViewController: ViewController {
    
    // MARK: - Subviews
    
    private let detailsView: AlbumDetailsView
    
    // MARK: - View Model
    
    private let viewModel: AlbumDetailsViewModelable
    
    // MARK: - Initialization
    
    init(viewModel: AlbumDetailsViewModelable) {
        self.detailsView = .init()
        self.viewModel = viewModel
        super.init()
        self.viewModel.delegate = self
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    // MARK: - Setups
    
    private func setupController() {
        displayLoadingView()
        viewModel.loadDetails()
        navigationItem.title = viewModel.albumName
    }
}

// MARK: - Album Details View Model Delegate

extension AlbumDetailsViewController: AlbumDetailsViewModelDelegate {
    func viewModel(_ viewModel: AlbumDetailsViewModel, didLoad details: AlbumInformation) {
        print("\(details) 🤩🤩🤩")
        DispatchQueue.main.async {
            self.detailsView.configure(with: details)
            self.hideLoadingView()
        }
    }
}
