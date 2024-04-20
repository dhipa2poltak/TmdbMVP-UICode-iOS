//
//  MovieByGenreView.swift
//  feature_movie_by_genre
//
//  Created by user on 30/03/24.
//

import Foundation
import UIKit
import app_framework
import SnapKit

class MovieByGenreView: ProgrammaticView {

    let lblTitle = UILabel()
    let vwLine = UILabel()
    let tableVw = UITableView()

    override func configure() {
        backgroundColor = .white

        lblTitle.font = .systemFont(ofSize: 20.0, weight: .bold)

        vwLine.backgroundColor = .lightGray

        tableVw.backgroundColor = .clear
        tableVw.separatorStyle = .none
    }

    override func constrain() {
        addSubview(lblTitle)
        addSubview(vwLine)
        addSubview(tableVw)

        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }

        vwLine.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(8)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }

        tableVw.snp.makeConstraints { make in
            make.top.equalTo(vwLine.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
