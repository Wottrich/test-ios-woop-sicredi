//
//  EventSlowTests.swift
//  EventOverviewSlowTests
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import EventOverview

class EventTests: XCTestCase {

    var fakeEvent: DataMock!
    var fakeListEvent: DataMock!
    
    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        self.fakeEvent = DataMock(bundle: testBundle, forResourse: "event", ofType: "json")
        self.fakeListEvent = DataMock(bundle: testBundle, forResourse: "events", ofType: "json")
    }

    override func tearDown() {
        self.fakeEvent = nil
        self.fakeListEvent = nil
    }

    func testFake_MapEventWithSuccess () {
        
        let fakeData = self.fakeEvent.jsonObject()
        
        if let json = fakeData as? [String: AnyObject] {
            let eventJson: Event? = Event(JSON: json)
            XCTAssertNotNil(eventJson)
        } else {
            XCTFail("Invalid json.")
        }
        
        let eventMap: Event? = self.fakeEvent.map(type: Event.self)
        XCTAssertNotNil(eventMap)
        
    }
    
    func testFake_MapListEventWithSuccess () {
        
        let fakeData = self.fakeListEvent.jsonObject()
        
        if let JSONArray = fakeData as? Array<[String: AnyObject]> {
            
            let eventJson: [Event]? = JSONArray.map { (dictionary) -> Event in
                if let event = Event(JSON: dictionary) {
                    return event
                } else {
                    XCTFail("Event is null, mappable not completed")
                    return Event()
                }
            }
            XCTAssertNotNil(eventJson)
        } else {
            XCTFail("Invalid array json.")
        }
        
        let eventMap: [Event]? = self.fakeListEvent.mapArray(type: Event.self)
        XCTAssertNotNil(eventMap)
        
    }

}
