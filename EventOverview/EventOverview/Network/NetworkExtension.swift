//
//  NetworkExtension.swift
//  EventOverview
//
//  Created by Wottrich on 16/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

extension Network: BaseNetworkProtocol {
    
    class func buildRequest(_ anotherUrl: String? = nil, _ networkProtocol: NetworkProtocol) throws -> URLRequest {
        
        var request: URLRequest
        
        if let baseUrl = anotherUrl {
            let url = baseUrl + networkProtocol.url
            request = URLRequest(url: URL(string: url)!)
        } else {
            let url = Constants.API.baseUrl + networkProtocol.url
            request = URLRequest(url: URL(string: url)!)
        }
        
        request.httpMethod = networkProtocol.httpMethod.rawValue
        request.allHTTPHeaderFields = networkProtocol.headers?.dictionary
        request.timeoutInterval = 180
        
        let parameters = networkProtocol.parameters ?? [:]
        let encoding = networkProtocol.encoding
        
        return try encoding.encode(request, with: parameters)
        
    }
    
    class func loadObject<T: Mappable> (
        _ json: [String: Any],
        _ completion: @escaping (T?) -> Void,
        _ failure: @escaping (String) -> Void
    ) {
        
        if let response = Mapper<T>().map(JSON: json) {
            completion(response)
        } else {
            failure(NetworkDefaultErrors.defaultError.rawValue)
        }
        
    }
    
    class func loadArray<T: Mappable> (
        _ array: Array<[String: AnyObject]>,
        _ completion: @escaping ([T]) -> Void,
        _ failure: @escaping (String) -> Void
    ) {
        
        if let response = Mapper<T>().mapArray(JSONObject: array) {
            completion(response)
        } else {
            failure(NetworkDefaultErrors.defaultError.rawValue)
        }
        
    }
    
    class func printLog<T>(_ response: DataResponse<T, AFError>) {
        guard let request = response.request else { return }
        guard let url = request.url else { return }
        guard let httpMethod = request.httpMethod else { return }

        print("->REQUEST(\(httpMethod))\n\(url)\n")

        if let requestHeaders = request.allHTTPHeaderFields {
            print("->HEADERS\n\(requestHeaders)\n")
        }

        if let httpBody = request.httpBody {
            print(String.init(data: httpBody, encoding: .utf8) ?? "")
        }

        var statusCode = 0
        if let response = response.response {
            statusCode = response.statusCode
        }

        let statusCodeString = (statusCode != 0) ? "(\(statusCode))" : ""
        print("->RESPONSE" + statusCodeString + "\n\(response.description)\n")

        if let data = response.data {
            
            if let content = String(data: data, encoding: .utf8)?.data(using: .utf8) {
                do {
                    let object = try JSONSerialization.jsonObject(with: content, options: []) as? [String: Any]
                    print(object as Any)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
