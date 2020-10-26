//
//  UIViewController.swift
//  CoreKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import UIKit

public extension UIViewController {
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(subView: UIView) {
        view.willRemoveSubview(subView)
        subView.removeFromSuperview()
        view.layoutIfNeeded()
    }
}
