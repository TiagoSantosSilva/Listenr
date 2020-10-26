//
//  ViewController.swift
//  CoreKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import UIKit

open class ViewController: UIViewController, LoadingViewPresentable {
    
    // MARK: - Subviews
    
    lazy public var loadingView: LoadingView = .init()
    lazy public var serviceFailView: ServiceFailView = .init()
    
    // MARK: - Initialization
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError(UIKitError.unavailableXIB)
    }
}
