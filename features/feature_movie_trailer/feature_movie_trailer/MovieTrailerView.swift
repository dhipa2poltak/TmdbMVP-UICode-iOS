//
//  MovieTrailerView.swift
//  feature_movie_trailer
//
//  Created by user on 30/03/24.
//

import Foundation
import YouTubePlayer
import app_framework
import SnapKit

class MovieTrailerView: ProgrammaticView {

    let youtubePlayer = YouTubePlayerView()

    override func configure() {}

    override func constrain() {
        addSubview(youtubePlayer)

        youtubePlayer.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
