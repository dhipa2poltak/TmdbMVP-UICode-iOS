//
//  MovieReviewView.swift
//  feature_movie_review
//
//  Created by user on 30/03/24.
//

import Foundation
import UIKit
import SnapKit
import app_framework

class MovieReviewView: ProgrammaticView {

    let lblTitleMovie = UILabel()
    let lblTitleReview = UILabel()
    let vwLine = UILabel()
    let tableVw = UITableView()
    let lblNoReview = UILabel()

    override func configure() {
        backgroundColor = .white

        lblTitleMovie.font = .systemFont(ofSize: 20, weight: .bold)
        lblTitleReview.text = NSLocalizedString("key_review", comment: "")
        lblTitleReview.font = .systemFont(ofSize: 20, weight: .bold)

        vwLine.backgroundColor = .lightGray

        tableVw.backgroundColor = .clear
        tableVw.separatorStyle = .singleLine

        lblNoReview.text = NSLocalizedString("key_no_review_available", comment: "")
        lblNoReview.isHidden = false
    }

    override func constrain() {
        addSubview(lblTitleMovie)
        addSubview(lblTitleReview)
        addSubview(vwLine)
        addSubview(tableVw)
        addSubview(lblNoReview)

        lblTitleReview.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.centerX.equalToSuperview()
        }

        lblTitleMovie.snp.makeConstraints { make in
            make.top.equalTo(lblTitleReview.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        vwLine.snp.makeConstraints { make in
            make.top.equalTo(lblTitleMovie.snp.bottom).offset(8)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }

        tableVw.snp.makeConstraints { make in
            make.top.equalTo(vwLine.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
