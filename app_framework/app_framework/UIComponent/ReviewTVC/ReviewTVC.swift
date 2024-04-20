//
//  ReviewTVC.swift
//  app_framework
//
//  Created by user on 30/03/24.
//

import Foundation
import Kingfisher
import UIKit
import SnapKit
import domain

public class ReviewTVC: UITableViewCell {

    public let vw = ReviewView()

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

    public func bindData(review: ReviewEntity) {
        vw.lblContent.text = review.content

        if let avatarPath = review.authorDetails?.avatarPath {
            vw.ivAuthor.kf.setImage(with: URL(string: avatarPath))
        }

        vw.lblAuthor.text = review.author
    }
}
