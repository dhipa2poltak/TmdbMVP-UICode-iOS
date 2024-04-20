//
//  MovieReviewVM.swift
//  feature_movie_review
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift
import app_framework
import domain

public class MovieReviewPresenter {

    public weak var viewDelegate: MovieReviewVD?
    private let getMovieReviewUseCase: GetMovieReviewUseCase?
    private let disposeBag = DisposeBag()

    public var movieId = -1
    public var movieTitle = ""
    var page = 0

    private var reviews: [ReviewEntity] = []

    public init(getMovieReviewUseCase: GetMovieReviewUseCase?) {
        self.getMovieReviewUseCase = getMovieReviewUseCase
    }

    func fetchMovieReviews() {
        guard getMovieReviewUseCase != nil else {
            self.viewDelegate?.showErrorMessageToUser(errorMessage: "error dependency")
            return
        }

        self.viewDelegate?.showLoading(isLoading: true)
        let thePage = page + 1

        getMovieReviewUseCase?.call(movieId: movieId, page: thePage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                self?.viewDelegate?.showLoading(isLoading: false)

                let reviews = response.results
                if reviews.count > 0 {
                    self?.reviews.append(contentsOf: reviews)
                    self?.viewDelegate?.reloadTable()
                    self?.page = thePage
                }
            }, onError: { [weak self] error in
                self?.viewDelegate?.showLoading(isLoading: false)
                self?.viewDelegate?.showErrorMessageToUser(errorMessage: "error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
    }

    func getNumberOfReview() -> Int {
        return self.reviews.count
    }

    func getReviewAt(index: Int) -> ReviewEntity {
        return self.reviews[index]
    }

    func clearReviewData() {
        self.reviews.removeAll()
        self.page = 0
    }
}
