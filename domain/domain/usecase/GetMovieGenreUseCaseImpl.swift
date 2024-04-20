//
//  GetMovieGenreUseCaseImpl.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift

public struct GetMovieGenreUseCaseImpl: GetMovieGenreUseCase {

    let appRepository: AppRepository

    public init(appRepository: AppRepository) {
        self.appRepository = appRepository
    }

    public func call() -> Observable<GenreDomain> {
        return appRepository.fetchMovieGenre()
    }
}
