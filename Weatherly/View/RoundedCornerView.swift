//
//  RoundedCornerView.swift
//  Weatherly
//
//  Created by Derek Chang on 7/18/22.
//

import Foundation
import UIKit

@IBDesignable
class RoundedCornerView: UIView {
    
    // if cornerRadius variable is set/changed, change the corner radius of the UIView
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
}
