//
//  GetMovieTrailerUseCase.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift

public protocol GetMovieTrailerUseCase {
    func call(movieId: Int) -> Observable<TrailerDomain>
}
