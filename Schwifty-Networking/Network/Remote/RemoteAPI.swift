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
    func request<T: Decodable>(_ route: Route) -> Single<T>
    func request<T: Decodable>(_ route: Route) -> Promise<T>
    func request<T: Decodable>(_ route: Route,
                               successHandler: @escaping ((_ result: T) -> Void),
                               errorHandler: @escaping ((_ error: Error) -> Void))
}
