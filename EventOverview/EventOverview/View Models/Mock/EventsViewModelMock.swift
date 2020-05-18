//
//  EventsViewModelMock.swift
//  EventOverview
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import Foundation

class EventsViewModelMock: EventsViewModelProtocol {
    
    let dataMock: DataMock!
    
    init(dataMock: DataMock) {
        self.dataMock = dataMock
    }
    
    var events: [Event] = []
    
    func loadEvents(completion: @escaping (Data?, String?) -> Void) throws {
        try EventServiceMock.getEvents(data: self.dataMock, completion: completion)
    }
    
    
}
