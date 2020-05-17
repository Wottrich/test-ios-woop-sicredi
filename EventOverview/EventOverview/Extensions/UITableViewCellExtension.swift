//
//  UITableViewCellExtension.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    @objc class func height() -> CGFloat {
        return 44.0
    }
    
    func removeSelectionHighlight() {
        self.selectionStyle = .none
    }
    
    func addSelectionHighlight() {
        self.selectionStyle = .default
    }
}
