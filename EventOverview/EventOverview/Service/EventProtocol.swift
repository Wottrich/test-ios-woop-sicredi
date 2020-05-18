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
    case checkIn(eventId: String, name: String, email: String)
}

class EventProtocol: NetworkProtocol {
    
    let route: EventRoute
    
    var url: String {
        switch route {
        case .events:
            return "events"
        case let .event(id):
            return "events/\(id)"
        case .checkIn:
            return "checkin"
        }
    }
    
    var headers: HTTPHeaders?
    
    var httpMethod: HTTPMethod {
        switch route {
        case .checkIn:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch route {
        case let .checkIn(eventId, name, email):
            var parameters: [String: String] = [:]
            parameters["eventId"] = eventId
            parameters["name"] = name
            parameters["email"] = email
            
            return parameters
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch route {
        case .checkIn:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
        
    }
    
    var returnIsEmpty: Bool {
        switch route {
        case .checkIn:
            return true
        default:
            return false
        }
    }
    
    init(route: EventRoute) {
        self.route = route
    }
    
}
