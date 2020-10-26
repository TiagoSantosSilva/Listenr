//
//  ChartTopTagsSearchController.swift
//  Listenr
//
//  Created by Tiago Silva on 25/10/2020.
//

import CoreKit
import UIKit

final class ChartTopTagsSearchController: UISearchController {
    
    // MARK: - Initialization
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(UIKitError.unavailableXIB)
    }
    
    // MARK: - Setups
    
    private func setupController() {
        definesPresentationContext = false
        obscuresBackgroundDuringPresentation = false
    }
}
