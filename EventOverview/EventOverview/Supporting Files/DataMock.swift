//
//  DataMock.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import Foundation
import ObjectMapper

class DataMock {
    
    var data: Data!
    
    init(bundle: Bundle, forResourse: String, ofType: String) {
        let path = bundle.path(forResource: forResourse, ofType: ofType)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        self.data = data
    }
    
    open func jsonObject () -> Any? {
        return try? JSONSerialization.jsonObject(with: self.data, options: JSONSerialization.ReadingOptions(rawValue: 0))
    }
    
    open func map<T: Mappable>(data: Data? = nil, type _: T.Type) -> T? {
        let data = try? JSONSerialization.jsonObject(with: data ?? self.data, options: JSONSerialization.ReadingOptions(rawValue: 0))
        return Mapper<T>().map(JSONObject: data)
    }
    
    open func mapArray<T: Mappable>(data: Data? = nil, type _: T.Type) -> [T]? {
        let data = try? JSONSerialization.jsonObject(with: data ?? self.data, options: JSONSerialization.ReadingOptions(rawValue: 0))
        return Mapper<T>().mapArray(JSONObject: data)
    }
    
}
