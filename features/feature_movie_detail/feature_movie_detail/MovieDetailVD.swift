//
//  MovieDetailVD.swift
//  feature_movie_detail
//
//  Created by user on 30/03/24.
//

import Foundation

public protocol MovieDetailVD: AnyObject {
    func showLoading(isLoading: Bool)
    func showMovieTitle(movieTitle: String)
    func showMovieImage(urlImage: String)
    func showMovieDescription(movieDescription: String)
    func showErrorMessageToUser(errorMessage: String)
}
