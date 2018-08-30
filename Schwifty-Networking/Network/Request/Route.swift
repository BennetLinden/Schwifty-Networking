//
//  Route.swift
//  Schwifty-Networking
//
//  Created by Bennet van der Linden on 30/08/2018.
//  Copyright © 2018 Schwifty. All rights reserved.
//

import Foundation
import Alamofire

struct Route {

    let method: HTTPMethod
    let path: String
    let parameters: [String: Any]?

    init(_ method: HTTPMethod, _ path: String, with params: [String: Any]? = nil) {
        self.method = method
        self.path = path
        self.parameters = params
    }
}
