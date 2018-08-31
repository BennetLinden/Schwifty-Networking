//
//  RemoteAPI.swift
//  Schwifty-Networking
//
//  Created by Bennet van der Linden on 30/08/2018.
//  Copyright © 2018 Schwifty. All rights reserved.
//

import Foundation
import RxSwift
import PromiseKit

protocol RemoteAPI {

    /**
     Returns a Single (Observable) of the decoded request response.
     
     - parameter route: Route object with HTTPMethod, path and optional parameters
     
     - returns: A Single (Observable) of the decoded request response
     */
    func request<T: Decodable>(_ route: Route) -> Single<T>

    /**
     Returns a Promise with the decoded request response.
     
     - parameter route: Route object with HTTPMethod, path and optional parameters
     
     - returns: A Promise with the decoded request response
     */
    func request<T: Decodable>(_ route: Route) -> Promise<T>

    /**
     Performs a request with two handlers to be called once the request has finished.
     
     - parameter route: Route object with HTTPMethod, path and optional parameters
     - parameter successHandler: The code to be executed when the request was successful
     - parameter errorHandler: The code to be executed in case the request produces an error
     
     - returns: A Promise with the decoded request response
     */
    func request<T: Decodable>(_ route: Route,
                               successHandler: @escaping ((_ result: T) -> Void),
                               errorHandler: @escaping ((_ error: Error) -> Void))
}
