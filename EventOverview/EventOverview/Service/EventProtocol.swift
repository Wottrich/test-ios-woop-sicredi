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
    case event(id: String)
}

class EventProtocol: NetworkProtocol {
    
    let route: EventRoute
    
    var url: String {
        switch route {
        case .events:
            return "events"
        case let .event(id):
            return "events/\(id)"
        }
    }
    
    var headers: HTTPHeaders?
    
    var httpMethod: HTTPMethod = .get
    
    var parameters: Parameters?
    
    var encoding: ParameterEncoding = URLEncoding.default
    
    var returnIsEmpty: Bool = false
    
    init(route: EventRoute) {
        self.route = route
    }
    
}
