//
//  MovieView.swift
//  app_framework
//
//  Created by user on 30/03/24.
//

import Foundation
import UIKit
import SnapKit

public class MovieView: ProgrammaticView {

    public let ivMovie = UIImageView()
    public let lblTitle = UILabel()
    public let lblOverview = UILabel()

    public override func configure() {
        ivMovie.contentMode = .scaleAspectFit
        lblTitle.font = UIFont.boldSystemFont(ofSize: 17)
        lblTitle.numberOfLines = 0
        lblOverview.numberOfLines = 0
    }

    public override func constrain() {
        addSubview(ivMovie)
        addSubview(lblTitle)
        addSubview(lblOverview)

        ivMovie.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }

        lblTitle.snp.makeConstraints { make in
            make.leading.equalTo(ivMovie.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        lblOverview.snp.makeConstraints { make in
            make.leading.equalTo(ivMovie.snp.trailing).offset(8)
            make.top.equalTo(lblTitle.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }
}
