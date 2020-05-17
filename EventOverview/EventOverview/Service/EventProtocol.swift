//
//  EventProtocol.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import Alamofire

enum EventRoute {
    case events
}

class EventProtocol: NetworkProtocol {
    
    let route: EventRoute
    
    var url: String = "events"
    
    var headers: HTTPHeaders?
    
    var httpMethod: HTTPMethod = .get
    
    var parameters: Parameters?
    
    var encoding: ParameterEncoding = URLEncoding.default
    
    var returnIsEmpty: Bool = false
    
    init(route: EventRoute) {
        self.route = route
    }
    
}
