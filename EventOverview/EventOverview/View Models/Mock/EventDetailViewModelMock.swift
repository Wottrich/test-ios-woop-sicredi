//
//  EventDetailViewModelMock.swift
//  EventOverview
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import Foundation

class EventDetailViewModelMock: EventDetailViewModelProtocol {
    
    let dataMock: DataMock!
    
    init(dataMock: DataMock) {
        self.dataMock = dataMock
    }
    
    var event: Event?
    
    var coupons: [Coupon] {
        get {
            return event?.coupons ?? []
        }
    }
    
    func getEventById (data: DataMock?, completion: @escaping (Data?, String?) -> Void) throws {
        try EventServiceMock.getEventById(data: data, completion: completion)
    }
    
    func checkIn (name: String, email: String, data: DataMock?, completion: @escaping (Data?, String?) -> Void) throws {
        try EventServiceMock.postCheckIn(name: name, email: email, data: data, completion: completion)
    }
    
}
