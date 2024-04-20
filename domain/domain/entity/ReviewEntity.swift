//
//  ReviewEntity.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation

public struct ReviewEntity {
    public let author: String
    public let authorDetails: AuthorDetailsEntity?
    public let content: String

    public init(author: String = "", authorDetails: AuthorDetailsEntity? = nil, content: String = "") {
        self.author = author
        self.authorDetails = authorDetails
        self.content = content
    }
}
