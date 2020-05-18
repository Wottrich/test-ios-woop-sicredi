//
//  UITableViewExtension.swift
//  EventOverview
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerXib<T: UITableViewCell> (type _: T.Type) {
        self.register(
            T.loadNib(),
            forCellReuseIdentifier: T.identifier
        )
    }
    
}
