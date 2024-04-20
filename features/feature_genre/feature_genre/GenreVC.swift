//
//  GenreVC.swift
//  feature_genre
//
//  Created by user on 30/03/24.
//

import SVProgressHUD
import UIKit
import app_framework

public class GenreVC: BaseVC {

    private let vw = GenreView()

    public var presenter: GenrePresenter?
    public var navigationService: NavigationService?

    private let cellId = "GenreContentTVC"
    
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
        // Do any additional setup after loading the view.
        print("Current configuration: \(BuildConfiguration.shared.environment)")
        print("Base URL: \(BuildConfiguration.shared.API_BASE_URL)")

        setupTableView()

        presenter?.loadData()
    }

    private func setupTableView() {
        if #available(iOS 10.0, *) {
            vw.tableVw.refreshControl = refreshControl
        } else {
            vw.tableVw.addSubview(refreshControl)
        }

        vw.tableVw.dataSource = self
        vw.tableVw.delegate = self

        vw.tableVw.register(GenreContentTVC.self, forCellReuseIdentifier: cellId)
    }

    @objc private func didRefreshControl() {
        presenter?.clearGenreData()
        self.vw.tableVw.reloadData()
        presenter?.loadData()
    }
}

extension GenreVC: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getTheNumberOfGenre() ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GenreContentTVC
        cell.selectionStyle = .none

        let genre = presenter?.getGenreAt(index: indexPath.row)
        cell.bindData(genreName: genre?.name)

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = presenter?.getGenreAt(index: indexPath.row)
        navigationService?.showMovieByGenre(genreId: genre?.id ?? -1, genreName: genre?.name ?? "")
    }
}

extension GenreVC: GenreVD {
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
    }

    public func showErrorMessageToUser(errorMessage: String) {
        navigationService?.showErrorMessage(errorMessage: errorMessage)
    }
}
