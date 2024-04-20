//
//  GetMovieReviewUseCase.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift

public protocol GetMovieReviewUseCase {
    func call(movieId: Int, page: Int) -> Observable<ReviewDomain>
}
