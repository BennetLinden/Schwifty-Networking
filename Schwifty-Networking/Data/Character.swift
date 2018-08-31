//
//  Character.swift
//  Schwifty-Networking
//
//  Created by Bennet van der Linden on 30/08/2018.
//  Copyright © 2018 Schwifty. All rights reserved.
//

import Foundation

struct Character: Codable, Equatable {

    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let imageURL: URL

    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type
        case imageURL = "image"
    }
}
