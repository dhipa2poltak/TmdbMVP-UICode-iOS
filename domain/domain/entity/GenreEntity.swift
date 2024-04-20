//
//  GenreEntity.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation

public struct GenreEntity {
    public let id: Int
    public let name: String

    public init(id: Int = -1, name: String = "") {
        self.id = id
        self.name = name
    }
}
