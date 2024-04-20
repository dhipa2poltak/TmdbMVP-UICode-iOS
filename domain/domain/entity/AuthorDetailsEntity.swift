//
//  AuthorDetailsEntity.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation

public struct AuthorDetailsEntity {
    public let avatarPath: String

    public init(avatarPath: String = "") {
        self.avatarPath = avatarPath
    }
}
