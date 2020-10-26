//
//  LoadingViewPresentable.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

public protocol LoadingViewPresentable {
    var loadingView: LoadingView { get }
    
    func displayLoadingView()
    func hideLoadingView()
}

public extension LoadingViewPresentable where Self: UIViewController {
    func displayLoadingView() {
        DispatchQueue.main.async {
            self.loadingView.appear()
            self.view.addSubview(self.loadingView)
            self.loadingView.constraintToAllFrame(of: self.view)
        }
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.disappear()
        }
    }
}

