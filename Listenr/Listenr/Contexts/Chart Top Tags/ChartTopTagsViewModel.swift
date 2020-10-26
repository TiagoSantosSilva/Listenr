//
//  ChartTopTagsViewModel.swift
//  Listenr
//
//  Created by Tiago Santos on 25/10/2020.
//

import CoreKit
import Foundation
import NetworkingKit

protocol ChartTopTagsViewModelDelegate: ServiceFailRecoverDelegate {
    func viewModelDidLoadChartTopTags(_ viewModel: ChartTopTagsViewModel)
}

protocol ChartTopTagsViewModelable: class {
    var tags: [ChartTopTag] { get }
    var delegate: ChartTopTagsViewModelDelegate? { get set }
    
    init(dependencies: DependencyContainable, selectedTag: ChartTopTag)
    
    func isTagSelected(tag: ChartTopTag) -> Bool
    func loadTopTags()
    func updateChartList(for searchText: String)
}

final class ChartTopTagsViewModel: ChartTopTagsViewModelable {
    
    // MARK: - Dependencies
    
    private let networkProvider: NetworkProvidable
    
    // MARK: - Delegate
    
    weak var delegate: ChartTopTagsViewModelDelegate?
    
    // MARK: - Properties
    
    var tags: [ChartTopTag] = []
    private var allTags: [ChartTopTag] = []
    private let selectedTag: ChartTopTag
    
    // MARK: - Initialization
    
    init(dependencies: DependencyContainable, selectedTag: ChartTopTag) {
        self.networkProvider = dependencies.networkProvider
        self.selectedTag = selectedTag
    }
    
    // MARK: - Functions
    
    func isTagSelected(tag: ChartTopTag) -> Bool {
        return tag == selectedTag
    }
    
    func loadTopTags() {
        networkProvider.request(endpoint: .chartTopTags()) { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case let .success(result):
                let loadedTags = result.values.tags
                let newTags: [ChartTopTag] = {
                    if !loadedTags.contains(where: { $0.name == self.selectedTag.name }) {
                        var tagsToReturn: [ChartTopTag] = [self.selectedTag]
                        tagsToReturn.append(contentsOf: loadedTags)
                        return tagsToReturn
                    } else {
                        return loadedTags
                    }
                }()
                self.allTags = newTags
                self.tags = newTags
                self.delegate?.viewModelDidLoadChartTopTags(self)
            case .failure:
                self.delegate?.viewModelDidFailServiceCall(self) { [weak self] in
                    self?.loadTopTags()
                }
            }
        }
    }
    
    func updateChartList(for searchText: String) {
        guard searchText != String.empty else {
            tags = allTags
            return
        }
        tags = allTags.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
