//
//  CouponTableViewCell.swift
//  EventOverview
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class CouponTableViewCell: BaseTableViewCell {

    static let height: CGFloat = 71.0
    
    @IBOutlet weak var couponTitleLabel: UILabel!
    @IBOutlet weak var discountCouponLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(coupon: Coupon, totalPrice: Double) {
        
        if let id = coupon.id {
            self.couponTitleLabel.text = "Coupon \(id)"
        } else {
            self.couponTitleLabel.text = "Coupon :)"
        }
        
        if let discount = coupon.discount {
            self.discountCouponLabel.text = "Desconto: \(discount.formatCurrency())"
            let total = totalPrice - discount
            self.totalPriceLabel.text = total < 0 ? "Free" : total.formatCurrency()
        } else {
            self.discountCouponLabel.text = "R$ 0,00"
            self.totalPriceLabel.text = totalPrice.formatCurrency()
        }
        
        
    }
    
}
