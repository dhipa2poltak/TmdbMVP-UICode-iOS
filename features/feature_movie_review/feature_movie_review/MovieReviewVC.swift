//
//  MovieReviewVC.swift
//  feature_movie_review
//
//  Created by user on 30/03/24.
//

import Foundation
import SVProgressHUD
import UIKit
import app_framework

public class MovieReviewVC: BaseVC {

    private let vw = MovieReviewView()
    public var presenter: MovieReviewPresenter?
    public var navigationService: NavigationService?

    private let cellId = "ReviewTVC"

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

        vw.lblTitleMovie.text = presenter?.movieTitle ?? "unknown"

        if let presenter = presenter {
            presenter.fetchMovieReviews()
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

        vw.tableVw.register(ReviewTVC.self, forCellReuseIdentifier: cellId)
    }

    @objc private func didRefreshControl() {
        presenter?.clearReviewData()
        self.vw.tableVw.reloadData()

        if let presenter = presenter {
            presenter.fetchMovieReviews()
        }
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)

        if distance < 200, let presenter = presenter {
            presenter.fetchMovieReviews()
        }
    }
}

extension MovieReviewVC: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfReview() ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReviewTVC

        if let review = presenter?.getReviewAt(index: indexPath.row) {
            cell.bindData(review: review)
        }

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension MovieReviewVC: MovieReviewVD {
    public func showLoading(isLoading: Bool) {
        if isLoading {
            SVProgressHUD.show()
        } else {
            self.refreshControl.endRefreshing()
            SVProgressHUD.dismiss()
        }
    }

    public func reloadTable() {
        self.refreshControl.endRefreshing()
        self.vw.tableVw.reloadData()

        let isEmpty = ((presenter?.getNumberOfReview() ?? 0) == 0)
        self.vw.lblNoReview.isHidden = !isEmpty
    }

    public func showErrorMessageToUser(errorMessage: String) {
        navigationService?.showErrorMessage(errorMessage: errorMessage)
    }
}
