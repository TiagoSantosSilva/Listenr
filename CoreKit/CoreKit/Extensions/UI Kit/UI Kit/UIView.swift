//
//  UIView.swift
//  CoreKit
//
//  Created by Tiago Santos on 24/10/2020.
//

import UIKit

public enum Axis {
    case horizontal
    case vertical
}

public extension UIView {

    func usesAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @discardableResult
    func pinToAllFrame(of view: UIView) -> Self {
        return pin(to: view, top: 0, leading: 0, trailing: 0, bottom: 0)
    }
    
    @discardableResult
    func pin(to view: UIView, top: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil) -> Self {
        
        if let topConstant = top {
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant).isActive = true
        }
        
        if let leadingConstant = leading {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant).isActive = true
        }
        
        if let trailingConstant = trailing {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailingConstant).isActive = true
        }
        
        if let bottomConstant = bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomConstant).isActive = true
        }
        
        usesAutoLayout()
        return self
    }

    @discardableResult
    func pin(to layoutGuide: UILayoutGuide,
             top: CGFloat? = nil,
             leading: CGFloat? = nil,
             trailing: CGFloat? = nil,
             bottom: CGFloat? = nil) -> Self {

        if let topConstant = top {
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: topConstant).isActive = true
        }

        if let leadingConstant = leading {
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: leadingConstant).isActive = true
        }

        if let trailingConstant = trailing {
            trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -trailingConstant).isActive = true
        }

        if let bottomConstant = bottom {
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -bottomConstant).isActive = true
        }

        usesAutoLayout()
        return self
    }

    @discardableResult
    func pinToSafeArea(of view: UIView, top: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil) -> Self {
        let safeArea = view.safeAreaLayoutGuide
        
        if let topConstant = top {
            topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topConstant).isActive = true
        }
        
        if let leadingConstant = leading {
            leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: leadingConstant).isActive = true
        }
        
        if let trailingConstant = trailing {
            trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -trailingConstant).isActive = true
        }
        
        if let bottomConstant = bottom {
            bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -bottomConstant).isActive = true
        }
        
        usesAutoLayout()
        return self
    }
    
    @discardableResult
    func constraint(height: CGFloat, multiplier: CGFloat = 1) -> Self {
        usesAutoLayout()
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func constraintToHeightAnchor(of parentView: UIView, multiplier: CGFloat = 1) -> Self {
        usesAutoLayout()
        heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult
    func constraint(width: CGFloat, multiplier: CGFloat = 1) -> Self {
        usesAutoLayout()
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func constraintToWidthAnchor(of parentView: UIView, multiplier: CGFloat = 1) -> Self {
        usesAutoLayout()
        widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult
    func center(axis: Axis, to parentView: UIView, constant: CGFloat = 0) -> Self {
        usesAutoLayout()
        switch axis {
        case .horizontal:
            centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: constant).isActive = true
        case .vertical:
            centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    @discardableResult
    func center(axis: Axis, to layoutGuide: UILayoutGuide, constant: CGFloat = 0) -> Self {
        usesAutoLayout()
        switch axis {
        case .horizontal:
            centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: constant).isActive = true
        case .vertical:
            centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    func addAndConstraintToAllFrame(childView: UIView) {
        childView.usesAutoLayout()
        addSubview(childView)
        constraintToAllFrame(view: childView)
    }
    
    func constraintToAllFrame(view: UIView) {
        let safeAreaLayoutGuide = self.safeAreaLayoutGuide
        view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        view.usesAutoLayout()
    }
    
    func constraintToAllFrame(of parentView: UIView) {
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        usesAutoLayout()
    }
    
    func hideWithFade(completion: VoidCompletion? = nil) {
        UIView.animate(withDuration: 0.2,
                       animations: { [weak self] in
                        self?.alpha = 0.0
            }, completion: { [weak self] _ in
                self?.isHidden = true
                completion?()
        })
    }
}
