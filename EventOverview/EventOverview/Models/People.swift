//
//  People.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import ObjectMapper

class People: NSObject {

    var id: String?
    var eventId: String?
    var name: String?
    var picture: String?
    
    override init() {}
    
    required init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
}

extension People: Mappable {
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.eventId <- map["eventId"]
        self.name <- map["name"]
        self.picture <- map["picture"]
    }
    
}
