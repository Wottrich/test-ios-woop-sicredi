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

    var fakeEvent: Data!
    
    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "event", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        self.fakeEvent = data
    }

    override func tearDown() {
        self.fakeEvent = nil
    }

    func testFake_MapEventWithSuccess () {
        
        let fakeData = try? JSONSerialization.jsonObject(with: self.fakeEvent, options: JSONSerialization.ReadingOptions(rawValue: 0))
        
        if let json = fakeData as? [String: AnyObject] {
            
            let eventJson = Event(JSON: json)
            XCTAssertNotNil(eventJson)
            
            let eventMap = Mapper<Event>().map(JSON: json)
            XCTAssertNotNil(eventMap)
            
        }
        
    }

}
