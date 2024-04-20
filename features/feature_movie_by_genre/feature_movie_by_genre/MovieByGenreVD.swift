//
//  MovieByGenreVD.swift
//  feature_movie_by_genre
//
//  Created by user on 30/03/24.
//

import Foundation

public protocol MovieByGenreVD: AnyObject {
    func showLoading(isLoading: Bool)
    func reloadTable()
    func showErrorMessageToUser(errorMessage: String)
}
