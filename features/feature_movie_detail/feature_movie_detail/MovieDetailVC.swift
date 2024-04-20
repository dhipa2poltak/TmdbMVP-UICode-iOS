//
//  MovieDetailVC.swift
//  feature_movie_detail
//
//  Created by user on 30/03/24.
//

import Foundation
import Kingfisher
import SVProgressHUD
import UIKit
import app_framework
import SnapKit

public class MovieDetailVC: BaseVC {

    private let scrollView = UIScrollView()
    private let vw = MovieDetailView()

    public var presenter: MovieDetailPresenter?
    public var navigationService: NavigationService?

    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(didRefreshControl), for: .valueChanged)
        return rc
    }()

    public override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.addSubview(vw)

        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        vw.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }

        scrollView.insertSubview(refreshControl, at: 0)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        super.setupNavBar()

        vw.btnShowReview.addTarget(self, action: #selector(onClickShowReview(_:)), for: .touchUpInside)
        vw.btnShowTrailer.addTarget(self, action: #selector(onClickShowTrailer(_:)), for: .touchUpInside)

        if let presenter = presenter {
            presenter.fetchMovieDetail()
        }
    }

    @objc private func didRefreshControl() {
        self.vw.lblTitleMovie.text = ""
        self.vw.lblDesc.text = ""

        if let presenter = presenter {
            presenter.fetchMovieDetail()
        }
    }

    @IBAction func onClickShowReview(_ sender: UIButton) {
        if let presenter = presenter {
            let movieId = presenter.movieId
            let movieTitle = presenter.movieTitle

            navigationService?.showMovieReview(movieId: movieId, movieTitle: movieTitle)
        }
    }

    @IBAction func onClickShowTrailer(_ sender: UIButton) {
        if let presenter = presenter {
            let movieId = presenter.movieId

            navigationService?.showMovieTrailer(movieId: movieId)
        }
    }
}

extension MovieDetailVC: MovieDetailVD {
    public func showLoading(isLoading: Bool) {
        if isLoading {
            SVProgressHUD.show()
        } else {
            refreshControl.endRefreshing()
            SVProgressHUD.dismiss()
        }
    }

    public func showMovieTitle(movieTitle: String) {
        self.vw.lblTitleMovie.text = movieTitle
    }

    public func showMovieImage(urlImage: String) {
        self.vw.ivMovie.kf.setImage(with: URL(string: urlImage))
    }

    public func showMovieDescription(movieDescription: String) {
        self.vw.lblDesc.text = movieDescription
    }

    public func showErrorMessageToUser(errorMessage: String) {
        navigationService?.showErrorMessage(errorMessage: errorMessage)
    }
}
