//
//  Network.swift
//  EventOverview
//
//  Created by Wottrich on 16/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

public enum NetworkDefaultErrors: String {
    case defaultError = "An error was occurent.\nPlease try again later."
}

public protocol NetworkProtocol {
    var url: String { get }
    
    var headers: HTTPHeaders? { get }
    
    var httpMethod: HTTPMethod { get }
    
    var parameters: Parameters? { get }
    
    var encoding: ParameterEncoding { get }
    
    var returnIsEmpty: Bool { get }
}

class Network {
    
    @discardableResult
    public class func request<T: Mappable> (
        _ networkProtocol: NetworkProtocol,
        anotherUrl: String? = nil,
        type _: T.Type,
        completion: @escaping (T?) -> Void = {_ in},
        completionArray: @escaping ([T]) -> Void = {_ in},
        failure: @escaping (String) -> Void
    ) throws -> DataRequest {
        
        return try AF.request(buildRequest(anotherUrl, networkProtocol)).printJson
            .responseJSON { response in
                
                switch(response.result) {
                case let .success(value):
                    
                    if networkProtocol.returnIsEmpty {
                        completion(nil)
                        return
                    }
                    
                    if let json = value as? [String: Any] {
                        loadObject(json, completion, failure)
                    } else if let array = value as? Array<[String: AnyObject]> {
                        loadArray(array, completionArray, failure)
                    } else {
                        failure(NetworkDefaultErrors.defaultError.rawValue)
                    }
                    
                case let .failure(error):
                    failure(error.localizedDescription)
                }
                
            }
    }
    
    @discardableResult
    public class func requestMock (
        _ networkProtocol: NetworkProtocol,
        anotherUrl: String? = nil,
        data: Data?,
        completion: @escaping (Data?) -> Void = {_ in},
        failure: @escaping (String) -> Void
    ) throws -> DataRequest {
        
        return try AF.request(buildRequest(anotherUrl, networkProtocol)).printJson
            .responseJSON { response in
                
                switch(response.result) {
                case .success:
                    
                    if networkProtocol.returnIsEmpty {
                        completion(nil)
                        return
                    }
                    
                    completion(data)
                
                case let .failure(error):
                    failure(error.localizedDescription)
                }
                
            }
    }
    
    
}

extension DataRequest {
    
    
    var printJson: DataRequest {
        get {
            return self.responseString(completionHandler: {Network.printLog($0)})
        }
    }
    
}
