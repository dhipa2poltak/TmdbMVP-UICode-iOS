//
//  MovieByGenreVC.swift
//  feature_movie_by_genre
//
//  Created by user on 30/03/24.
//

import Foundation
import SVProgressHUD
import UIKit
import app_framework

public class MovieByGenreVC: BaseVC {

    private let vw = MovieByGenreView()

    public var presenter: MovieByGenrePresenter?
    public var navigationService: NavigationService?

    private let cellId = "MovieTVC"

    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(didRefreshControl), for: .valueChanged)
        return rc
    }()

    public override func loadView() {
        super.loadView()
        view = vw
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        super.setupNavBar()
        setupTableView()

        if let presenter = presenter {
            if !presenter.genreName.isEmpty {
                vw.lblTitle.text = String(format: NSLocalizedString("key_title_movies_in_genre", comment: ""), presenter.genreName)
            }

            presenter.fetchMovieGenre()
        }
    }

    private func setupTableView() {
        if #available(iOS 10.0, *) {
            vw.tableVw.refreshControl = refreshControl
        } else {
            vw.tableVw.addSubview(refreshControl)
        }

        vw.tableVw.dataSource = self
        vw.tableVw.delegate = self

        vw.tableVw.register(MovieTVC.self, forCellReuseIdentifier: cellId)
    }

    @objc private func didRefreshControl() {
        presenter?.clearMovieData()
        self.vw.tableVw.reloadData()
        
        if let presenter = presenter {
            presenter.fetchMovieGenre()
        }
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)

        if distance < 200, let presenter = presenter {
            presenter.fetchMovieGenre()
        }
    }
}

extension MovieByGenreVC: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getTheNumberOfMovie() ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieTVC
        cell.selectionStyle = .none

        let movie = presenter?.getMovieAt(index: indexPath.row)
        cell.bindData(
            imageUrl: movie?.imageUrl ?? "",
            title: movie?.title ?? "",
            overview: movie?.overview ?? ""
        )

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = presenter?.getMovieAt(index: indexPath.row)
        navigationService?.showMovieDetail(movieId: movie?.id ?? -1)
    }
}

extension MovieByGenreVC: MovieByGenreVD {
    public func showLoading(isLoading: Bool) {
        if isLoading && presenter?.getTheNumberOfMovie() == 0 {
            SVProgressHUD.show()
        } else {
            self.refreshControl.endRefreshing()
            SVProgressHUD.dismiss()
        }
    }

    public func reloadTable() {
        self.refreshControl.endRefreshing()
        self.vw.tableVw.reloadData()
    }

    public func showErrorMessageToUser(errorMessage: String) {
        navigationService?.showErrorMessage(errorMessage: errorMessage)
    }
}
