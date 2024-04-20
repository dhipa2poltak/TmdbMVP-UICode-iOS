//
//  AppCoordinator.swift
//  TmdbMVP-UICode
//
//  Created by user on 31/03/24.
//

import Foundation
import Swinject
import UIKit
import app_framework
import data
import domain
import feature_genre
import feature_movie_by_genre
import feature_movie_detail
import feature_movie_review
import feature_movie_trailer
import feature_error_message

class AppCoordinator: NavigationService, Coordinator {
    private let container = Container()

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        registerDependencies()
    }

    private func registerDependencies() {
        self.container.register(AppCoordinator.self) { _ in
            self
        }.inObjectScope(.container)

        self.container.register(RestClient.self) { _ in
            RestClient()
        }.inObjectScope(.container)

        if let restClient = container.resolve(RestClient.self) {
            self.container.register(AppDataSource.self) { _ in
                return RemoteDataSourceImpl(restClient: restClient)
            }.inObjectScope(.container)
        }

        if let appDataSource = container.resolve(AppDataSource.self) {
            self.container.register(AppRepository.self) { _ in
                return AppRepositoryImpl(appDataSource: appDataSource)
            }.inObjectScope(.container)
        }

        if let appRepository = container.resolve(AppRepository.self) {
            self.container.register(GetMovieGenreUseCase.self) { _ in
                return GetMovieGenreUseCaseImpl(appRepository: appRepository)
            }
        }

        if let appRepository = container.resolve(AppRepository.self) {
            self.container.register(GetMovieByGenreUseCase.self) { _ in
                return GetMovieByGenreUseCaseImpl(appRepository: appRepository)
            }
        }

        if let appRepository = container.resolve(AppRepository.self) {
            self.container.register(GetMovieDetailsUseCase.self) { _ in
                return GetMovieDetailsUseCaseImpl(appRepository: appRepository)
            }
        }

        if let appRepository = container.resolve(AppRepository.self) {
            self.container.register(GetMovieReviewUseCase.self) { _ in
                return GetMovieReviewUseCaseImpl(appRepository: appRepository)
            }
        }

        if let appRepository = container.resolve(AppRepository.self) {
            self.container.register(GetMovieTrailerUseCase.self) { _ in
                return GetMovieTrailerUseCaseImpl(appRepository: appRepository)
            }
        }

        self.container.register(GenrePresenter.self) { resolver in
            GenrePresenter(getMovieGenreUseCase: resolver.resolve(GetMovieGenreUseCase.self))
        }

        self.container.register(MovieByGenrePresenter.self) { (resolver, genreId: Int, genreName: String) in
            let presenter = MovieByGenrePresenter(getMovieByGenreUseCase: resolver.resolve(GetMovieByGenreUseCase.self))
            presenter.genreId = genreId
            presenter.genreName = genreName

            return presenter
        }

        self.container.register(MovieDetailPresenter.self) { (resolver, movieId: Int) in
            let presenter = MovieDetailPresenter(getMovieDetailsUseCase: resolver.resolve(GetMovieDetailsUseCase.self))
            presenter.movieId = movieId

            return presenter
        }

        self.container.register(MovieReviewPresenter.self) { (resolver, movieId: Int, movieTitle: String) in
            let presenter = MovieReviewPresenter(getMovieReviewUseCase: resolver.resolve(GetMovieReviewUseCase.self))
            presenter.movieId = movieId
            presenter.movieTitle = movieTitle

            return presenter
        }

        self.container.register(MovieTrailerPresenter.self) { (resolver, movieId: Int) in
            let presenter = MovieTrailerPresenter(getMovieTrailerUseCase: resolver.resolve(GetMovieTrailerUseCase.self))
            presenter.movieId = movieId

            return presenter
        }
    }

    func start() {
        let vc = GenreVC()
        let presenter = container.resolve(GenrePresenter.self)
        presenter?.viewDelegate = vc
        vc.presenter = presenter
        vc.navigationService = container.resolve(AppCoordinator.self)

        navigationController.pushViewController(vc, animated: false)
    }

    func showMovieByGenre(genreId: Int, genreName: String) {
        let vc = MovieByGenreVC()
        let presenter = container.resolve(MovieByGenrePresenter.self, arguments: genreId, genreName)
        presenter?.viewDelegate = vc
        vc.presenter = presenter
        vc.navigationService = container.resolve(AppCoordinator.self)

        navigationController.pushViewController(vc, animated: true)
    }

    func showMovieDetail(movieId: Int) {
        let vc = MovieDetailVC()
        let presenter = container.resolve(MovieDetailPresenter.self, argument: movieId)
        presenter?.viewDelegate = vc
        vc.presenter = presenter
        vc.navigationService = container.resolve(AppCoordinator.self)

        navigationController.pushViewController(vc, animated: true)
    }

    func showMovieReview(movieId: Int, movieTitle: String) {
        let vc = MovieReviewVC()
        let presenter = container.resolve(MovieReviewPresenter.self, arguments: movieId, movieTitle)
        presenter?.viewDelegate = vc
        vc.presenter = presenter
        vc.navigationService = container.resolve(AppCoordinator.self)

        navigationController.pushViewController(vc, animated: true)
    }

    func showMovieTrailer(movieId: Int) {
        let vc = MovieTrailerVC()
        let presenter = container.resolve(MovieTrailerPresenter.self, argument: movieId)
        presenter?.viewDelegate = vc
        vc.presenter = presenter
        vc.navigationService = container.resolve(AppCoordinator.self)

        navigationController.pushViewController(vc, animated: true)
    }

    func showErrorMessage(errorMessage: String) {
        let vc = ErrorMessageBottomSheetVC(errorMessage: errorMessage)
        navigationController.viewControllers.last?.presentBottomSheet(viewController: vc)
    }
}
