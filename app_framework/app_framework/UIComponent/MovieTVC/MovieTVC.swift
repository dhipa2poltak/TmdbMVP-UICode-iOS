//
//  MovieTVC.swift
//  app_framework
//
//  Created by user on 30/03/24.
//

import Foundation
import Kingfisher
import UIKit
import SnapKit

public class MovieTVC: UITableViewCell {

    public let vw = MovieView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        selectionStyle = .none

        vw.layer.borderWidth = 1
        vw.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(vw)

        vw.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        }
    }

    public func bindData(imageUrl: String?, title: String?, overview: String?) {
        if let imageUrl = imageUrl, !imageUrl.isEmpty {
            vw.ivMovie.kf.setImage(with: URL(string: imageUrl))
        }

        vw.lblTitle.text = title
        vw.lblOverview.text = overview
    }
}
