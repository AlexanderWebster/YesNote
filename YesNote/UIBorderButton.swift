//
//  UIBorderButton.swift
//  YesNote
//
//  Created by Jeff Tobin on 10/24/17.
//  Copyright © 2017 Elad. All rights reserved.
//

import UIKit

//used for rhythm section buttons
class UIBorderButton: UIButton {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var tintedColor: UIColor = UIColor.white {
        didSet {
            tintColor = tintedColor
        }
    }
}
