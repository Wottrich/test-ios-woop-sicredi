//
//  EventDetailViewModelMock.swift
//  EventOverviewTests
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
@testable import EventOverview

class EventDetailViewModelMockTests: XCTestCase {

    var sut: EventDetailViewModelMock!
    
    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        let dataMock = DataMock(bundle: testBundle, forResourse: "event", ofType: "json")
        
        self.sut = EventDetailViewModelMock(dataMock: dataMock)
    }

    override func tearDown() {
        self.sut = nil
    }
    
    func testFake_RequestShouldReturnEvent_WithSuccess () {
        
        let requestExpectation = expectation(description: "Request should be return event and have one coupon with success")
        
        do {
            
            try self.sut.getEventById(data: self.sut.dataMock) { (data, error) in
                XCTAssertNil(error)
                
                self.sut.event = self.sut.dataMock.map(data: data, type: Event.self)
                
                requestExpectation.fulfill()
            }
            
            wait (for: [requestExpectation], timeout: 180.0)
            
            XCTAssertNotNil(self.sut.event)
            XCTAssertEqual(1, self.sut.coupons.count)
            
        } catch let error as NSError {
            XCTFail(error.localizedDescription)
        }
        
    }

}
