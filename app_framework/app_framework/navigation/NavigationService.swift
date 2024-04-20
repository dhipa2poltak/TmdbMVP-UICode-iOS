//
//  NavigationService.swift
//  app_framework
//
//  Created by user on 30/03/24.
//

import Foundation

public protocol NavigationService {

    func showMovieByGenre(genreId: Int, genreName: String)
    func showMovieDetail(movieId: Int)
    func showMovieReview(movieId: Int, movieTitle: String)
    func showMovieTrailer(movieId: Int)
    func showErrorMessage(errorMessage: String)
}
