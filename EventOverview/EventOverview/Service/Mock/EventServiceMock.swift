//
//  EventServiceMock.swift
//  EventOverview
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class EventServiceMock {
    
    class func getEvents(data: DataMock?, completion: @escaping (Data?, String?) -> Void) throws {
        try NetworkMock.requestMock(EventProtocol(route: .events), data: data?.data, completion: completion)
    }
    
    class func getEventById(data: DataMock?, completion: @escaping (Data?, String?) -> Void) throws {
        let event = data?.map(type: Event.self)
        guard let id = event?.id else { return }
        
        try NetworkMock.requestMock(EventProtocol(route: .event(id: id)), data: data?.data, completion: completion)
    }
    
    class func postCheckIn(name: String, email: String, data: DataMock?, completion: @escaping (Data?, String?) -> Void) throws {
        let event = data?.map(type: Event.self)
        guard let id = event?.id else { return }
        
        try NetworkMock.requestMock(
            EventProtocol(route: .checkIn(eventId: id, name: name, email: email)),
            data: data?.data,
            completion: completion
        )
    }
    
    
    
    
}
