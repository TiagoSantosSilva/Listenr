//
//  ChartTopTagsViewController.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import UIKit

protocol ChartTopTagsViewControllerDelegate: class {
    func viewController(_ viewController: ChartTopTagsViewController, didSelect tag: ChartTopTag)
    func viewControllerDidTapCloseButton(_ viewController: ChartTopTagsViewController)
}

final class ChartTopTagsViewController: ViewController {
    
    // MARK: - Subviews
    
    private let collectionViewController: ChartTopTagsCollectionViewController
    private let searchController: ChartTopTagsSearchController = .init(searchResultsController: nil)
    // MARK: - View Model
    
    private let viewModel: ChartTopTagsViewModelable
    
    // MARK: - Delegate
    
    weak var delegate: ChartTopTagsViewControllerDelegate?
    
    // MARK: - Constants
    
    private enum Constants {
        enum CloseButton {
            static let title: String = "Close"
        }
        
        enum NavigationItem {
            static let title: String = "Chart Top Tags"
        }
    }
    
    // MARK: - Initialization
    
    init(dataSource: ChartTopTagsDataSourceable, viewModel: ChartTopTagsViewModelable) {
        self.collectionViewController = .init(dataSource: dataSource, viewModel: viewModel)
        self.viewModel = viewModel
        super.init()
        self.viewModel.delegate = self
        self.collectionViewController.delegate = self
        self.searchController.searchBar.delegate = self
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    // MARK: - Functions
    
    private func setupController() {
        add(child: collectionViewController)
        collectionViewController.setup()
        setupSearch()
        view.backgroundColor = Color.backgroundGray
        displayLoadingView()
        viewModel.loadTopTags()
        let closeButton: UIBarButtonItem = .init(title: Constants.CloseButton.title, style: .done, target: self, action: #selector(closeButtonWasTapped))
        navigationItem.setLeftBarButton(closeButton, animated: false)
        navigationItem.title = Constants.NavigationItem.title
    }
    
    private func setupSearch() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    private func updateChartList(for searchText: String) {
        viewModel.updateChartList(for: searchText)
        let collectionView = collectionViewController.collectionView
        collectionView?.performBatchUpdates({
            collectionView?.reloadSections(IndexSet(integer: 0))
        }, completion: nil)
    }
    
    // MARK: - Selectors
    
    @objc private func closeButtonWasTapped(_ sender: UIBarButtonItem) {
        delegate?.viewControllerDidTapCloseButton(self)
    }
}

// MARK: - Chart Top Tags View Model Delegate

extension ChartTopTagsViewController: ChartTopTagsViewModelDelegate {
    func viewModelDidLoadChartTopTags(_ viewModel: ChartTopTagsViewModel) {
        DispatchQueue.main.async {
            self.collectionViewController.collectionView.reloadData()            
            self.hideLoadingView()
        }
    }
}

// MARK: - UI Search Bar Delegate

extension ChartTopTagsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateChartList(for: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateChartList(for: String.empty)
    }
}

// MARK: - Chart Top Tags Collection View Controller Delegate

extension ChartTopTagsViewController: ChartTopTagsCollectionViewControllerDelegate {
    func collectionViewController(_ collectionViewController: ChartTopTagsCollectionViewController, didSelectItemAt indexPath: IndexPath) {
        delegate?.viewController(self, didSelect: viewModel.tags[indexPath.row])
    }
}
