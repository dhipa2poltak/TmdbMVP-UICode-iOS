//
//  ReviewView.swift
//  app_framework
//
//  Created by user on 30/03/24.
//

import Foundation
import UIKit
import SnapKit

public class ReviewView: ProgrammaticView {

    public let lblContent = UILabel()
    public let ivAuthor = UIImageView()
    public let lblAuthor = UILabel()

    public override func configure() {
        lblContent.numberOfLines = 0
        lblAuthor.textAlignment = .right
    }

    public override func constrain() {
        addSubview(lblContent)
        addSubview(ivAuthor)
        addSubview(lblAuthor)

        lblContent.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.lessThanOrEqualTo(120)
        }

        ivAuthor.snp.makeConstraints { make in
            make.top.equalTo(lblContent.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(43)
        }

        lblAuthor.snp.makeConstraints { make in
            make.top.equalTo(ivAuthor.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12.5)
        }
    }
}
