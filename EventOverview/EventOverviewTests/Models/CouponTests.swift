//
//  CouponTests.swift
//  EventOverviewTests
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import EventOverview

class CouponTests: XCTestCase {

    var fakeCoupon: DataMock!
    var fakeCoupons: DataMock!
    
    override func setUp() {
        
        let testBundle = Bundle(for: type(of: self))
        self.fakeCoupon = DataMock(bundle: testBundle, forResourse: "coupon", ofType: "json")
        self.fakeCoupons = DataMock(bundle: testBundle, forResourse: "coupons", ofType: "json")
        
    }

    override func tearDown() {
        self.fakeCoupon = nil
        self.fakeCoupons = nil
    }

    func testFake_ShouldMapCouponWithSuccess () {
        
        let fakeData = self.fakeCoupon.jsonObject()
        
        if let json = fakeData as? [String: AnyObject] {
            let couponJson = Coupon(JSON: json)
            XCTAssertNotNil(couponJson)
        } else {
            XCTFail("Invalid json.")
        }
        
        let couponMap = self.fakeCoupon.map(type: People.self)
        XCTAssertNotNil(couponMap)
        
    }
    
    func testFake_MapPeopleListWithSuccess () {
        
        let fakeData = self.fakeCoupons.jsonObject()
        
        if let JSONArray = fakeData as? Array<[String: AnyObject]> {
            let couponJson = JSONArray.map { (dictionary) -> Coupon in
                if let event = Coupon(JSON: dictionary) {
                    return event
                } else {
                    XCTFail("Coupon is null, mappable not completed")
                    return Coupon()
                }
            }
            XCTAssertNotNil(couponJson)
        } else {
            XCTFail("Invalid json.")
        }
        
        let couponMap = self.fakeCoupons.mapArray(type: People.self)
        XCTAssertNotNil(couponMap)
        
    }

}
