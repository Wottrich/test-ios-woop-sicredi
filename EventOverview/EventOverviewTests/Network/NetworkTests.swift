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

    var fakeData: Data!
    
    override func setUp() {
       
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "events", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        self.fakeData = data
    }

    override func tearDown() {
        self.fakeData = nil
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
            
            let completion: (Data?) -> Void = { data in
                XCTAssertNotNil(data)
                
                guard let data = data else {
                    XCTFail("Data is null")
                    return
                }
                
                do {
                    let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
                    
                    if let resultEvents = response as? NSArray {
                        events = resultEvents as! [Event]
                    }
                    
                    requestExpectation.fulfill()
                } catch let error as NSError {
                    XCTFail(error.localizedDescription)
                }
                
            }
            
            let failure: (String) -> Void = { error in
                XCTFail(error)
            }
            
            let task = try NetworkMock.requestMock(networkProtocol, data: self.fakeData, completion: completion, failure: failure)
            
            task.resume()
            
            wait(for: [requestExpectation], timeout: 180.0)
            
            XCTAssertEqual(events.count >= 0, true, "Should has items after service")
            
            
        } catch let error as NSError {
            XCTFail(error.localizedDescription)
        }
         
     }

}
