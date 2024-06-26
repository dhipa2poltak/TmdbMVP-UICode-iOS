//
//  SpokenLanguage.swift
//  data
//
//  Created by user on 30/03/24.
//

import Foundation

struct SpokenLanguage: Codable {
    let iso6391: String?
    let name: String?
    let englishName: String?

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name
        case englishName = "english_name"
    }

    init(
        iso6391: String?,
        name: String?,
        englishName: String?
    ) {
        self.iso6391 = iso6391
        self.name = name
        self.englishName = englishName
    }
}
