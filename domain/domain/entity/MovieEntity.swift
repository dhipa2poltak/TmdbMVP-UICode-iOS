//
//  MovieEntity.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation

public struct MovieEntity {
    public let id: Int
    public let title: String
    public let overview: String
    public let imageUrl: String

    public init(id: Int = -1, title: String = "", overview: String = "", imageUrl: String = "") {
        self.id = id
        self.title = title
        self.overview = overview
        self.imageUrl = imageUrl
    }
}
