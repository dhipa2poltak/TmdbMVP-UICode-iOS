//
//  MovieReviewVD.swift
//  feature_movie_review
//
//  Created by user on 30/03/24.
//

import Foundation

public protocol MovieReviewVD: AnyObject {
    func showLoading(isLoading: Bool)
    func reloadTable()
    func showErrorMessageToUser(errorMessage: String)
}
