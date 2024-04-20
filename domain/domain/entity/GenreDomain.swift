//
//  GenreDomain.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation

public struct GenreDomain {
    public let genres: [GenreEntity]

    public init(genres: [GenreEntity] = []) {
        self.genres = genres
    }
}
