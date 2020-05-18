//
//  EventsViewModelTests.swift
//  EventOverviewTests
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
@testable import EventOverview

class EventsViewModelTests: XCTestCase {

    var sut: EventsViewModel!
    var sutMock: EventsViewModelMock!
    
    override func setUp() {
        self.sut = EventsViewModel()
        
        let testBundle = Bundle(for: type(of: self))
        let dataMock = DataMock(bundle: testBundle, forResourse: "events", ofType: "json")
        self.sutMock = EventsViewModelMock(dataMock: dataMock)
        
    }

    override func tearDown() {
        self.sut = nil
    }
    
    
    func test_ResquestShould_FinishWithSuccess () {
        
        let requestExpectation = expectation(description: "Request should finish with success")
        
        sut.loadEvents { (error) in
            
            XCTAssertNil(error)
            requestExpectation.fulfill()
            
        }
        
        wait(for: [requestExpectation], timeout: 180.0)
        
        XCTAssertEqual(true, sut.events.count >= 0)
        
    }
    
    func testFake_RequestShould_Return3Items_FinishWithSuccess () {
        
        let requestExpectation = expectation(description: "Request should return 3 items and finish with success")
        
        XCTAssertEqual(0, sutMock.events.count, "Event must be empty before request")
        
        do {
            
            try sutMock.loadEvents { (data, error) in
                XCTAssertNil(error)
                
                let request = self.sutMock.dataMock.mapArray(data: data, type: Event.self)
                
                if let array = request {
                    self.sutMock.events = array
                    requestExpectation.fulfill()
                } else {
                    XCTFail("Request is null")
                }
                
            }
            
            wait(for: [requestExpectation], timeout: 180.0)
            
            XCTAssertEqual(3, self.sutMock.events.count)
            
        } catch let error as NSError {
            XCTFail(error.localizedDescription)
        }
        
    }

}
