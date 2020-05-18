//
//  EventCheckInFooterTableViewCell.swift
//  EventOverview
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class EventCheckInFooterTableViewCell: UITableViewCell {

    static let height: CGFloat = 60.0
    
    var onClick: () -> Void = {}
    
    @IBOutlet weak var checkInButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(title: String?, color: UIColor? = nil) {
        if let title = title {
            self.checkInButton.titleLabel?.text = title
        }
        
        if let color = color {
            self.checkInButton.backgroundColor = color
        }
    }
    
    @IBAction func didTapCheckIn(_ sender: Any) {
        self.onClick()
    }
}
