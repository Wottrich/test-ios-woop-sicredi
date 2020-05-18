//
//  BaseTableViewCell.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath?
    
    var removeSelectionHighlight: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
        if removeSelectionHighlight {
            self.removeSelectionHighlight()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        
    }
    
    func addAcessoryView() {
        self.accessoryType = .disclosureIndicator
    }

}
