//
//  MovieTrailerVM.swift
//  feature_movie_trailer
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift
import app_framework
import domain

public class MovieTrailerPresenter {

    public weak var viewDelegate: MovieTrailerVD?
    private let getMovieTrailerUseCase: GetMovieTrailerUseCase?
    private let disposeBag = DisposeBag()

    public var movieId = -1

    public init(getMovieTrailerUseCase: GetMovieTrailerUseCase?) {
        self.getMovieTrailerUseCase = getMovieTrailerUseCase
    }

    func fetchMovieTrailer() {
        guard getMovieTrailerUseCase != nil else {
            self.viewDelegate?.showErrorMessageToUser(errorMessage: "error dependency")
            return
        }

        self.viewDelegate?.showLoading(isLoading: true)

        getMovieTrailerUseCase?.call(movieId: movieId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                self?.viewDelegate?.showLoading(isLoading: false)

                let trailers = response.results
                for trailer in trailers {
                    if trailer.site.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "youtube" {
                        self?.viewDelegate?.showMovieTrailer(movieKey: trailer.key)
                        break
                    }
                }
            }, onError: { [weak self] error in
                self?.viewDelegate?.showLoading(isLoading: false)
                self?.viewDelegate?.showErrorMessageToUser(errorMessage: "error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
    }
}
