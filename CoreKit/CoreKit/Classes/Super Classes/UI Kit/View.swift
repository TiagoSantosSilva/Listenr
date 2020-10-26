//
//  View.swift
//  CoreKit
//
//  Created by Tiago Silva on 24/10/2020.
//

import UIKit

open class View: UIView {
    
    // MARK: - Initialization
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError(UIKitError.unavailableXIB)
    }
}
