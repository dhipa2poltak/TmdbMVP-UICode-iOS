//
//  Genre.swift
//  data
//
//  Created by user on 30/03/24.
//

import Foundation

struct Genre: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}
