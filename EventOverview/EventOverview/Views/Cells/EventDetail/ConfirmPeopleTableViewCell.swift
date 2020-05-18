//
//  ConfirmPeopleTableViewCell.swift
//  EventOverview
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class ConfirmPeopleTableViewCell: BaseTableViewCell {

    static let height: CGFloat = 60.0
    
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(peopleCount: String) {
        self.peopleCountLabel.text = peopleCount
    }
    
}
