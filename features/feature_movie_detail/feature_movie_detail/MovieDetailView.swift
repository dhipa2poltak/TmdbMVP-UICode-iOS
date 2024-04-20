//
//  MovieDetailView.swift
//  feature_movie_detail
//
//  Created by user on 30/03/24.
//

import Foundation
import UIKit
import app_framework
import SnapKit

class MovieDetailView: ProgrammaticView {

    let lblTitleMovie = UILabel()
    let ivMovie = UIImageView()
    let lblDesc = UILabel()
    let btnShowReview = UIButton()
    let btnShowTrailer = UIButton()

    override func configure() {
        lblTitleMovie.font = .systemFont(ofSize: 20, weight: .bold)
        lblDesc.numberOfLines = 0

        btnShowReview.setTitle(NSLocalizedString("key_show_review", comment: ""), for: .normal)
        btnShowReview.setTitleColor(.systemBlue, for: .normal)
        btnShowTrailer.setTitle(NSLocalizedString("key_show_trailer", comment: ""), for: .normal)
        btnShowTrailer.setTitleColor(.systemBlue, for: .normal)
    }

    override func constrain() {
        addSubview(lblTitleMovie)
        addSubview(ivMovie)
        addSubview(lblDesc)
        addSubview(btnShowReview)
        addSubview(btnShowTrailer)

        lblTitleMovie.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.centerX.equalToSuperview()
        }

        ivMovie.snp.makeConstraints { make in
            make.top.equalTo(lblTitleMovie.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
        }

        lblDesc.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(ivMovie.snp.bottom).offset(20)
        }

        btnShowReview.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(lblDesc.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        btnShowTrailer.snp.makeConstraints { make in
            make.top.equalTo(btnShowReview.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
        }
    }
}
