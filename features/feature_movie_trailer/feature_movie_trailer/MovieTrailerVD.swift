//
//  MovieTrailerVD.swift
//  feature_movie_trailer
//
//  Created by user on 30/03/24.
//

import Foundation

public protocol MovieTrailerVD: AnyObject {
    func showLoading(isLoading: Bool)
    func showMovieTrailer(movieKey: String)
    func showErrorMessageToUser(errorMessage: String)
}
