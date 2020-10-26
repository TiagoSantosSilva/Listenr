//
//  RoundableButton.swift
//  CoreKit
//
//  Created by Tiago Silva on 25/10/2020.
//

import UIKit

class RoundableButton: UIButton {
    
    // MARK: - Properties
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            super.layer.cornerRadius = cornerRadius
            super.layer.masksToBounds = cornerRadius > 0
        }
    }
    
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
}
