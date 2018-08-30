//
//  ResultsResponse.swift
//  Schwifty-Networking
//
//  Created by Bennet van der Linden on 30/08/2018.
//  Copyright © 2018 Schwifty. All rights reserved.
//

import Foundation

struct ResultsResponse<T: Decodable>: Decodable {
    var results: T
}
