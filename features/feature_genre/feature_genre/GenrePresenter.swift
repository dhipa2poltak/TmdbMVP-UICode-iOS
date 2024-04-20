//
//  GenreVM.swift
//  feature_genre
//
//  Created by user on 30/03/24.
//

import Foundation
import RxSwift
import app_framework
import domain

public class GenrePresenter {

    public weak var viewDelegate: GenreVD?
    private let getMovieGenreUseCase: GetMovieGenreUseCase?
    private let disposeBag = DisposeBag()

    private var genres = [GenreEntity]()

    public init(getMovieGenreUseCase: GetMovieGenreUseCase?) {
        self.getMovieGenreUseCase = getMovieGenreUseCase
    }

    func loadData() {
        fetchMovieGenre()
    }

    func fetchMovieGenre() {
        guard getMovieGenreUseCase != nil else {
            viewDelegate?.showErrorMessageToUser(errorMessage: "error dependency")
            return
        }

        viewDelegate?.showLoading(isLoading: true)

        getMovieGenreUseCase?.call()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                self?.viewDelegate?.showLoading(isLoading: false)

                self?.genres.append(contentsOf: response.genres)
                self?.viewDelegate?.reloadTable()
            }, onError: { [weak self ] error in
                self?.viewDelegate?.showLoading(isLoading: false)
                self?.viewDelegate?.showErrorMessageToUser(errorMessage: "error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
    }

    func getTheNumberOfGenre() -> Int {
        return genres.count
    }

    func getGenreAt(index: Int) -> GenreEntity {
        return genres[index]
    }

    func clearGenreData() {
        self.genres.removeAll()
    }
}
