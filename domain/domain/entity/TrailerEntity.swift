//
//  TrailerEntity.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation

public struct TrailerEntity {
    public let id: String
    public let key: String
    public let name: String
    public let site: String

    public init(id: String = "", key: String = "", name: String = "", site: String = "") {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
    }
}
