//
//  GetMovieDetailsUseCase.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift

public protocol GetMovieDetailsUseCase {
    func call(movieId: Int) -> Observable<MovieDetailsDomain>
}
