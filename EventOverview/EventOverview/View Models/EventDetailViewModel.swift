//
//  EventDetailViewModel.swift
//  EventOverview
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import Foundation

enum EventEntry {
    
    case header
    case location
    case description
    case confirmPeople
    
    static var allValue: [EventEntry] {
        return [
            .header,
            .location,
            .description,
            .confirmPeople
        ]
    }
    
}

class EventDetailViewModel {
    
    var event: Event?
    
    var coupons: [Coupon] {
        get {
            return event?.coupons ?? []
        }
    }
    
    var checkingInProgress: Bool = false
    
    func getEventById (id: String, callback: @escaping (String?) -> Void) {
        
        EventService.getEventById(id: id, success: { (event) in
            
            self.event = event
            callback(nil)
            
        }, failure: { error in
            callback(error)
        })
        
    }
    
    func checkIn (name: String, email: String, callback: @escaping (String?) -> Void) {
        
        if let eventId = event?.id {
            EventService.postCheckIn(eventId: eventId, name: name, email: email, completion: callback)
        }
        
    }
    
}
