//
//  ViewController.swift
//  Schwifty-Networking
//
//  Created by Bennet van der Linden on 30/08/2018.
//  Copyright © 2018 Schwifty. All rights reserved.
//

import UIKit
import RxSwift
import PromiseKit

class ViewController: UIViewController {

    let remoteAPI: RemoteAPI = RickAndMortyAPI()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         Example of a remoteAPI implementation with a Single (Observable)
         */
        let observableRequest: Single<ResultsResponse<[Character]>> = remoteAPI.request(Route(.get, "character"))
        observableRequest
            .map { $0.results }
            .subscribe(onSuccess: { characters in
                print(characters)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)

        /**
         Example of a remoteAPI implementation with a Promise
         */
        let promiseRequest: Promise<ResultsResponse<[Character]>> = remoteAPI.request(Route(.get, "character"))
        promiseRequest
            .map({ $0.results })
            .done { characters in
                print(characters)
            }.catch { error in
                print(error.localizedDescription)
        }

        /**
         Example of a remoteAPI implementation with a successHandler and an errorHandler
         */
        let successHandler: ((_ result: ResultsResponse<[Character]>) -> Void) = {
            print($0.results)
        }
        let errorHandler: ((_ error: Error) -> Void) = {
            print($0.localizedDescription)
        }
        remoteAPI.request(Route(.get, "character"),
                          successHandler: successHandler,
                          errorHandler: errorHandler)
    }
}
