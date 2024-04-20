//
//  GetMovieDetailsUseCaseImpl.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift

public struct GetMovieDetailsUseCaseImpl: GetMovieDetailsUseCase {

    let appRepository: AppRepository

    public init(appRepository: AppRepository) {
        self.appRepository = appRepository
    }

    public func call(movieId: Int) -> Observable<MovieDetailsDomain> {
        return appRepository.fetchMovieDetail(movieId: movieId)
    }
}
