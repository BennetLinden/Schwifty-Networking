//
//  RequestBuilder.swift
//  Schwifty-Networking
//
//  Created by Bennet van der Linden on 30/08/2018.
//  Copyright © 2018 Schwifty. All rights reserved.
//

import Foundation
import Alamofire

final class RequestBuilder {

    private var method: HTTPMethod?
    private var endpoint: URL?
    private var params: [String: Any]?
    private var headers: [String: String]?

    func setEndpoint(_ endpoint: URL) -> RequestBuilder {
        self.endpoint = endpoint
        return self
    }

    func setMethod(_ method: HTTPMethod) -> RequestBuilder {
        self.method = method
        return self
    }

    func setParams(_ params: [String: Any]?) -> RequestBuilder {
        self.params = params
        return self
    }

    func addParams(_ params: [String: Any]) -> RequestBuilder {
        self.params = (self.params ?? [:]).merging(params, uniquingKeysWith: { $1 })
        return self
    }

    func setHeaders(_ headers: [String: String]?) -> RequestBuilder {
        self.headers = headers
        return self
    }

    func addHeaders(_ headers: [String: String]) -> RequestBuilder {
        self.headers = (self.headers ?? [:]).merging(headers, uniquingKeysWith: { $1 })
        return self
    }

    private struct Request: Requestable {
        let method: HTTPMethod
        let endpoint: URL
        let parameters: [String: Any]?
        let headers: [String: String]?
    }

    func build() -> Requestable {

        guard let method = method, let endpoint = endpoint else {
            fatalError("Request is incomplete. Missing httpmethod and/or endpoint")
        }

        return Request(method: method,
                       endpoint: endpoint,
                       parameters: params,
                       headers: headers)
    }
}
