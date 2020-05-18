//
//  PeopleTests.swift
//  EventOverviewTests
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import EventOverview

class PeopleTests: XCTestCase {

    var fakePeople: DataMock!
    var fakePeopleList: DataMock!
    
    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        self.fakePeople = DataMock(bundle: testBundle, forResourse: "people", ofType: "json")
        self.fakePeopleList = DataMock(bundle: testBundle, forResourse: "peopleList", ofType: "json")
    }

    override func tearDown() {
        self.fakePeople = nil
    }

    func testFake_MapPeopleWithSuccess () {
        
        let fakeData = self.fakePeople.jsonObject()
        
        if let json = fakeData as? [String: AnyObject] {
            let peopleJson = People(JSON: json)
            XCTAssertNotNil(peopleJson)
        } else {
            XCTFail("Invalid json.")
        }
        
        let peopleMap = self.fakePeople.map(type: People.self)
        XCTAssertNotNil(peopleMap)
        
    }
    
    func testFake_MapPeopleListWithSuccess () {
        
        let fakeData = self.fakePeopleList.jsonObject()
        
        if let JSONArray = fakeData as? Array<[String: AnyObject]> {
            let peopleJson = JSONArray.map { (dictionary) -> People in
                if let event = People(JSON: dictionary) {
                    return event
                } else {
                    XCTFail("Event is null, mappable not completed")
                    return People()
                }
            }
            XCTAssertNotNil(peopleJson)
        } else {
            XCTFail("Invalid json.")
        }
        
        let peopleMap = self.fakePeopleList.mapArray(type: People.self)
        XCTAssertNotNil(peopleMap)
        
    }

}
