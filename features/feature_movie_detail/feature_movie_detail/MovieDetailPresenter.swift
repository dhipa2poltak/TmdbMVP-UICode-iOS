//
//  MovieDetailVM.swift
//  feature_movie_detail
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift
import app_framework
import domain

public class MovieDetailPresenter {

    public weak var viewDelegate: MovieDetailVD?
    private let getMovieDetailsUseCase: GetMovieDetailsUseCase?
    private let disposeBag = DisposeBag()

    public var movieId = -1
    public var movieTitle = ""

    public init(getMovieDetailsUseCase: GetMovieDetailsUseCase?) {
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
    }

    func fetchMovieDetail() {
        guard getMovieDetailsUseCase != nil else {
            viewDelegate?.showErrorMessageToUser(errorMessage: "error dependency")
            return
        }

        viewDelegate?.showLoading(isLoading: true)

        getMovieDetailsUseCase?.call(movieId: movieId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                self?.viewDelegate?.showLoading(isLoading: false)

                self?.movieTitle = response.title
                self?.viewDelegate?.showMovieTitle(movieTitle: self?.movieTitle ?? "Unknown")
                self?.viewDelegate?.showMovieImage(urlImage: response.imageUrl)
                self?.viewDelegate?.showMovieDescription(movieDescription: response.overview)
            }, onError: { [weak self] error in
                self?.viewDelegate?.showLoading(isLoading: false)
                self?.viewDelegate?.showErrorMessageToUser(errorMessage: "error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
    }
}
