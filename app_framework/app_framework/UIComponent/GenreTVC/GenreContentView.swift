//
//  GenreContentView.swift
//  app_framework
//
//  Created by user on 30/03/24.
//

import Foundation
import UIKit
import SnapKit

public class GenreContentView: ProgrammaticView {

    public let lblGenre = UILabel()

    public override func configure() {}

    public override func constrain() {
        addSubview(lblGenre)

        lblGenre.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
    }
}
