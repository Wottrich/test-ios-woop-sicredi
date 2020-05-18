//
//  EventService.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class EventService {
    
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

}
