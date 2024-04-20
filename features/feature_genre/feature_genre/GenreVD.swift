//
//  GenreVD.swift
//  feature_genre
//
//  Created by user on 30/03/24.
//

import Foundation

public protocol GenreVD: AnyObject {
    func showLoading(isLoading: Bool)
    func reloadTable()
    func showErrorMessageToUser(errorMessage: String)
}
