//
//  Event.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import ObjectMapper

class Event: NSObject {

    var peopleList: [People] = []
    var coupons: [Coupon] = []
    
    var date: Date?
    var dateNumber: NSNumber?
    var longitude: NSNumber?
    var latitude: NSNumber?
    var price: Double?
    
    var eventDescription: String?
    var image: String?
    var title: String?
    var id: String?
    
    override init() {}
    
    required init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }

}

extension Event: Mappable {
    
    func mapping(map: Map) {
        self.dateNumber <- map["date"]
        
        if let timeInterval = dateNumber as? TimeInterval {
            self.date = Date(timeIntervalSince1970: timeInterval / 1000)
        }
        
        self.longitude <- map["longitude"]
        self.latitude <- map["latitude"]
        self.price <- map["price"]
        self.eventDescription <- map["description"]
        self.image <- map["image"]
        self.title <- map["title"]
        self.id <- map["id"]
        
        self.peopleList <- map["people"]
        self.coupons <- map["cupons"]
    }
    
}
