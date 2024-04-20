//
//  RemoteDataSourceImpl.swift
//  app_framework
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift
import domain
import data

public class RemoteDataSourceImpl: AppDataSource {

    let restClient: RestClient

    public init(restClient: RestClient) {
        self.restClient = restClient
    }

    public func fetchMovieGenre() -> Observable<GenreResponse> {
        return restClient.fetchMovieGenre()
    }

    public func fetchMovieByGenre(genreId: String, page: Int) -> Observable<DiscoverMovieByGenreResponse> {
        return restClient.fetchMovieByGenre(genreId: genreId, page: page)
    }

    public func fetchMovieDetail(movieId: Int) -> Observable<MovieDetailsResponse> {
        return restClient.fetchMovieDetail(movieId: movieId)
    }

    public func fetchMovieReviews(movieId: Int, page: Int) -> Observable<ReviewResponse> {
        return restClient.fetchMovieReviews(movieId: movieId, page: page)
    }

    public func fetchMovieTrailer(movieId: Int) -> Observable<TrailerResponse> {
        return restClient.fetchMovieTrailer(movieId: movieId)
    }
}
