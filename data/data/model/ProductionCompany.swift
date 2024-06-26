//
//  ProductionCompany.swift
//  data
//
//  Created by user on 30/03/24.
//

import Foundation

struct ProductionCompany: Codable {
    let name: String?
    let originCountry: String?
    let logoPath: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case originCountry = "origin_country"
        case logoPath = "logo_path"
        case id
    }

    init(
        name: String?,
        originCountry: String?,
        logoPath: String?,
        id: Int?
    ) {
        self.name = name
        self.originCountry = originCountry
        self.logoPath = logoPath
        self.id = id
    }
}
