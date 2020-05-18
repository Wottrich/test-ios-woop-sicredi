//
//  Coupon.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import ObjectMapper

class Coupon: NSObject {

    var id: String?
    var eventId: String?
    var discount: Double?
    
    override init(){}
    
    required init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
}

extension Coupon: Mappable {
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.eventId <- map["eventId"]
        self.discount <- map["discount"]
    }
    
}
