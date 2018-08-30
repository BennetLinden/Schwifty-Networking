//
//  Requestable.swift
//  Schwifty-Networking
//
//  Created by Bennet van der Linden on 30/08/2018.
//  Copyright © 2018 Schwifty. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable: URLRequestConvertible {

    var method: Alamofire.HTTPMethod { get }
    var endpoint: URL { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension Requestable {

    private var encoding: Alamofire.ParameterEncoding {
        switch method {
        case .get: return Alamofire.URLEncoding.default
        default: return Alamofire.JSONEncoding.default
        }
    }

    public func asURLRequest() throws -> URLRequest {
        let request: URLRequest = {
            var request = URLRequest(url: endpoint)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            return request
        }()
        return try encoding.encode(request, with: parameters)
    }
}
