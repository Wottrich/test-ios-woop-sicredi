//
//  EventsTableViewCell.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class EventsTableViewCell: UITableViewCell {
    
    static let height: CGFloat = 72.0

    @IBOutlet weak var titleEventLabel: UILabel!
    @IBOutlet weak var dateEventLabel: UILabel!
    @IBOutlet weak var priceEventLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(event: Event) {
        
        if let url = event.image {
            self.loadImage(photoUrl: url)
        }
        
        if let titleEvent = event.title {
            self.titleEventLabel.text = titleEvent
        }
        
        if let date = event.date {
            self.dateEventLabel.text = "Data: \(date.formatDate())"
        }
        
        if let price = event.price {
            self.priceEventLabel.text = "Preço: \(price.formatCurrency())"
        }
        
    }
    
    func loadImage (photoUrl: String) {
        
        DispatchQueue.main.async {
            if let url = URL.init(string: photoUrl) {
                self.eventImage.kf.indicatorType = .activity
                self.eventImage.setImage(with: url)
            }
        }
        
    }
    
}
