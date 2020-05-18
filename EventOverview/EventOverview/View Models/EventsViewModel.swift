//
//  EventsViewModel.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

protocol EventsViewModelProtocol {
    
    var events: [Event] { get }
    
}

class EventsViewModel: EventsViewModelProtocol {

    var events: [Event] = []
    
    func loadEvents (callback: @escaping (String?) -> Void) {
        
        EventService.getEvents(success: { events in
            
            self.events = events
            callback(nil)
            
        }, failure: { error in
            callback(error)
        })
        
    }
    
}
