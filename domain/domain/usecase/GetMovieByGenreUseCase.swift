//
//  GetMovieByGenreUseCase.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift

public protocol GetMovieByGenreUseCase {
    func call(genreId: String, page: Int) -> Observable<DiscoverMovieByGenreDomain>
}
