//
//  Coordinator.swift
//  TmdbMVP-UICode
//
//  Created by user on 31/03/24.
//

import Foundation
import UIKit

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
