//
//  ReviewDomain.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation

public struct ReviewDomain {
    public let results: [ReviewEntity]

    public init(results: [ReviewEntity] = []) {
        self.results = results
    }
}
