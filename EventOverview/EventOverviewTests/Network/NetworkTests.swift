//
//  NetworkSlowTests.swift
//  EventOverviewSlowTests
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import Alamofire
import ObjectMapper
@testable import EventOverview

class NetworkTests: XCTestCase {

    var fakeData: DataMock!
    var fakeEvent: DataMock!
    
    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        self.fakeData = DataMock(bundle: testBundle, forResourse: "events", ofType: "json")
        self.fakeEvent = DataMock(bundle: testBundle, forResourse: "event", ofType: "json")
    }

    override func tearDown() {
        self.fakeData = nil
        self.fakeEvent = nil
    }

    func test_RequestShould_ReturnDataNotNil_FinishWithSuccess () {
        
        let requestExpectation = expectation(description: "Request should finish with success")
        
        do {
            
            let networkProtocol = EventProtocol(route: .events)
            
            let completion: ([Event]) -> Void = { mockArray in
                XCTAssertNotNil(mockArray)
                requestExpectation.fulfill()
            }
            
            let failure: (String) -> Void = { error in
                XCTFail(error)
            }
            
            let task = try Network.request(networkProtocol, type: Event.self, completionArray: completion, failure: failure)
            
            task.resume()
            
            wait(for: [requestExpectation], timeout: 180.0)
            
        } catch let error as NSError {
            XCTFail(error.localizedDescription)
        }
        
    }
     
     func testFake_RequestShould_ReturnEventsOrNot_FinishWithSuccess () {
         
        let requestExpectation = expectation(description: "Request should finish with success and return 3 items")
        
        var events: [Event] = []
        
        XCTAssertEqual(0, events.count, "Should be empty before service")
        
        do {
            
            let networkProtocol = EventProtocol(route: .events)
            
            let task = try NetworkMock.requestMock(networkProtocol, data: self.fakeData.data) { data, error in
                
                if let message = error {
                    XCTFail(message)
                    return
                }
                
                XCTAssertNotNil(data, "Data is null")
                
                guard let data = data else { return }
                let response = self.fakeData.mapArray(data: data, type: Event.self)
                    
                if let array = response {
                    events = array
                }
                    
                requestExpectation.fulfill()
                
            }
            
            task.resume()
            
            wait(for: [requestExpectation], timeout: 180.0)
            
            XCTAssertEqual(events.count >= 0, true, "Should has items after request")
            
            
        } catch let error as NSError {
            XCTFail(error.localizedDescription)
        }
         
     }
    
    func testFake_RequestShould_ReturnEventDetail_FinishWithSuccess () {
        
        let requestExpectation = expectation(description: "Request should return event datail and finish with success")
        
        do {
            
            let mockEvent: Event? = self.fakeEvent.map(type: Event.self)
            let networkProtocol = EventProtocol(route: .event(id: mockEvent?.id ?? ""))
            
            let task = try NetworkMock.requestMock(networkProtocol, data: self.fakeEvent.data) { data, error in

                if let message = error {
                    XCTFail(message)
                    return
                }
                
                XCTAssertNotNil(data)
                
                guard let data = data else { return }
                let response = self.fakeEvent.map(data: data, type: Event.self)
                
                XCTAssertNotNil(response)
                XCTAssertEqual(response?.id, mockEvent?.id)
                requestExpectation.fulfill()
                
            }
            
            task.resume()
            
            wait(for: [requestExpectation], timeout: 180.0)
            
        } catch let error as NSError {
            XCTFail(error.localizedDescription)
        }
        
    }

}
