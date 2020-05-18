//
//  NetworkMock.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire 

class NetworkMock: BaseNetworkProtocol {
    
    @discardableResult
    public class func requestMock (
        _ networkProtocol: NetworkProtocol,
        anotherUrl: String? = nil,
        data: Data?,
        completion: @escaping (Data?, String?) -> Void = {_, _ in}
    ) throws -> DataRequest {
        
        return try AF.request(buildRequest(anotherUrl, networkProtocol)).printJson
            .responseJSON { response in
                
                switch(response.result) {
                case .success:
                    
                    if networkProtocol.returnIsEmpty {
                        completion(nil, nil)
                        return
                    }
                    
                    completion(data, nil)
                
                case let .failure(error):
                    completion(nil, error.localizedDescription)
                }
                
            }
    }
    
    static func buildRequest(
        _ anotherUrl: String?,
        _ networkProtocol: NetworkProtocol
    ) throws -> URLRequest {
        try Network.buildRequest(anotherUrl, networkProtocol)
    }
    
    static func loadObject<T: Mappable>(
        _ json: [String : Any],
        _ completion: @escaping (T?) -> Void,
        _ failure: @escaping (String) -> Void
    ) {
        Network.loadObject(json, completion, failure)
    }
    
    static func loadArray<T: Mappable>(
        _ array: Array<[String : AnyObject]>,
        _ completion: @escaping ([T]) -> Void,
        _ failure: @escaping (String) -> Void
    ) {
        Network.loadArray(array, completion, failure)
    }

}
