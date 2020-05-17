//
//  DoubleExtension.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

extension Double {

    func formatCurrency (currencySymbol: String = "R$", location: String = "pt-br") -> String {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: location)
        formatter.currencySymbol = currencySymbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(floatLiteral: self)) ?? ""
    }
    
}
