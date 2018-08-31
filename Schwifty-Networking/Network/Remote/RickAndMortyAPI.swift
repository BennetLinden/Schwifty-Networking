//
//  RickAndMortyAPI.swift
//  Schwifty-Networking
//
//  Created by Bennet van der Linden on 30/08/2018.
//  Copyright © 2018 Schwifty. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
import PromiseKit

class RickAndMortyAPI: RemoteAPI {

    private let host: URL = URL(string: "https://rickandmortyapi.com/api/")!
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    /**
     Returns a Single (Observable) of the decoded request response.
     
     - parameter route: Route object with HTTPMethod, path and optional parameters
     
     - returns: A Single (Observable) of the decoded request response
     */
    func request<T: Decodable>(_ route: Route) -> Single<T> {

        let request = RequestBuilder()
            .setMethod(route.method)
            .setEndpoint(host.appendingPathComponent(route.path))
            .setParams(route.parameters)
            .build()

        return RxAlamofire
            .request(request)
            .validate()
            .responseData()
            .map({ try self.decoder.decode(T.self, from: $0.1) })
            .asSingle()
    }

    /**
     Returns a Promise with the decoded request response.
     
     - parameter route: Route object with HTTPMethod, path and optional parameters
     
     - returns: A Promise with the decoded request response
     */
    func request<T: Decodable>(_ route: Route) -> Promise<T> {

        let request = RequestBuilder()
            .setMethod(route.method)
            .setEndpoint(host.appendingPathComponent(route.path))
            .setParams(route.parameters)
            .build()

        return Alamofire
            .request(request)
            .validate()
            .responseDecodable(decoder: decoder)
    }

    /**
     Performs a request with two handlers to be called once the request has finished.
     
     - parameter route: Route object with HTTPMethod, path and optional parameters
     - parameter successHandler: The code to be executed when the request was successful
     - parameter errorHandler: The code to be executed in case the request produces an error
     
     - returns: A Promise with the decoded request response
     */
    func request<T: Decodable>(_ route: Route,
                               successHandler: @escaping ((T) -> Void),
                               errorHandler: @escaping ((Error) -> Void)) {

        let request = RequestBuilder()
            .setMethod(route.method)
            .setEndpoint(host.appendingPathComponent(route.path))
            .setParams(route.parameters)
            .build()

        Alamofire
            .request(request)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try self.decoder.decode(T.self, from: data)
                        successHandler(decodedData)
                    } catch let error {
                        errorHandler(error)
                    }

                case .failure(let error):
                    errorHandler(error)
                }
        }
    }
}
