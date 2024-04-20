//
//  MovieByGenreVM.swift
//  feature_movie_by_genre
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift
import app_framework
import domain

public class MovieByGenrePresenter {

    public weak var viewDelegate: MovieByGenreVD?
    private let getMovieByGenreUseCase: GetMovieByGenreUseCase?
    private let disposeBag = DisposeBag()

    public var genreId = -1
    public var genreName = ""
    private var page = 0

    private var movies = [MovieEntity]()

    public init(getMovieByGenreUseCase: GetMovieByGenreUseCase?) {
        self.getMovieByGenreUseCase = getMovieByGenreUseCase
    }

    func fetchMovieGenre() {
        guard getMovieByGenreUseCase != nil else {
            viewDelegate?.showErrorMessageToUser(errorMessage: "error dependency")
            return
        }

        viewDelegate?.showLoading(isLoading: true)
        let thePage = page + 1

        getMovieByGenreUseCase?.call(genreId: "\(self.genreId)", page: thePage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                self?.viewDelegate?.showLoading(isLoading: false)

                let movies = response.results
                if movies.count > 0 {
                    self?.movies.append(contentsOf: movies)
                    self?.page = thePage
                    self?.viewDelegate?.reloadTable()
                }
            }, onError: { [weak self] error in
                self?.viewDelegate?.showLoading(isLoading: false)
                self?.viewDelegate?.showErrorMessageToUser(errorMessage: "error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
    }

    func getTheNumberOfMovie() -> Int {
        return self.movies.count
    }

    func getMovieAt(index: Int) -> MovieEntity {
        return self.movies[index]
    }

    func clearMovieData() {
        self.movies.removeAll()
        self.page = 0
    }
}
