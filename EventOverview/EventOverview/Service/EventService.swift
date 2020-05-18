//
//  EventService.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

protocol EventServiceProtocol {
    
    static func getEvents (
        success: @escaping ([Event]) -> Void,
        failure: @escaping (String) -> Void
    )
    
    static func getEventById (
        id: String,
        success: @escaping (Event) -> Void,
        failure: @escaping (String) -> Void
    )
    
    static func postCheckIn (
        eventId: String, name: String, email: String,
        completion: @escaping (String?) -> Void
    )
    
}

class EventService: EventServiceProtocol {
    
    class func getEvents (
        success: @escaping ([Event]) -> Void,
        failure: @escaping (String) -> Void
    ) {
        
        do {
            
            try Network.request(
                EventProtocol(route: .events),
                type: Event.self,
                completionArray: success,
                failure: failure
            )
            
        } catch let error as NSError {
            failure(error.localizedDescription)
        }
        
    }
    
    class func getEventById (
        id: String,
        success: @escaping (Event) -> Void,
        failure: @escaping (String) -> Void
    ) {
        
        do {
            
            try Network.request(
                EventProtocol(route: .event(id: id)),
                type: Event.self,
                completion: { event in
                    if let saveEvent = event {
                        success(saveEvent)
                    } else {
                        failure(NetworkDefaultErrors.defaultError.rawValue)
                    }
                },
                failure: failure
            )
            
        } catch let error as NSError {
            failure(error.localizedDescription)
        }
        
    }
    
    class func postCheckIn (
        eventId: String, name: String, email: String,
        completion: @escaping (String?) -> Void
    ) {
        
        do {
            
            let networkProtocol = EventProtocol(route: .checkIn(eventId: eventId, name: name, email: email))
            
            try Network.request(networkProtocol, type: Event.self, completion: { data in
                completion(nil)
            }, failure: { error in
                completion(error)
            })
            
        } catch let error as NSError {
            completion(error.localizedDescription)
        }
        
    }

}
