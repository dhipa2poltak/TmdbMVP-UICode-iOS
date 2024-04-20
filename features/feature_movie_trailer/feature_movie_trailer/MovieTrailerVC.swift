//
//  MovieTrailerVC.swift
//  feature_movie_trailer
//
//  Created by user on 30/03/24.
//

import Foundation
import SVProgressHUD
import UIKit
import YouTubePlayer
import app_framework

public class MovieTrailerVC: BaseVC, YouTubePlayerDelegate {

    let vw = MovieTrailerView()
    public var presenter: MovieTrailerPresenter?
    public var navigationService: NavigationService?

    public override func loadView() {
        super.loadView()

        view = vw
        view.backgroundColor = .white
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        super.setupNavBar()

        vw.youtubePlayer.delegate = self

        if let presenter = presenter {
            presenter.fetchMovieTrailer()
        }
    }

    public func playerReady(_ videoPlayer: YouTubePlayerView) {
        vw.youtubePlayer.play()
    }
}

extension MovieTrailerVC: MovieTrailerVD {
    public func showLoading(isLoading: Bool) {
        if isLoading {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }

    public func showMovieTrailer(movieKey: String) {
        if !movieKey.isEmpty {
            self.vw.youtubePlayer.loadVideoID(movieKey)
        }
    }

    public func showErrorMessageToUser(errorMessage: String) {
        navigationService?.showErrorMessage(errorMessage: errorMessage)
    }
}
