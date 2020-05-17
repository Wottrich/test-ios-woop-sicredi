//
//  UIViewExtension.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

extension UIView {

    class func loadFromNibNamed(_ nibNamed: String, _ bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: nibNamed, bundle: bundle)
    }
    
    class func loadNib() -> UINib {
        let className = String(describing: self)
        return loadFromNibNamed(className)
    }
    
}
