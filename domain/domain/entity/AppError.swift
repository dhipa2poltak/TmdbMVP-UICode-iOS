//
//  AppError.swift
//  domain
//
//  Created by user on 30/03/24.
//

import Foundation

public enum AppError: Error {
    case networkError(message: String)
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .networkError(message):
            return message
        }
    }
}
