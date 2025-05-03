//
//  AppCoordinator.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI
import UIKit

protocol AppCoordinator: Coordinator {
    
}

final class AppCoordinatorImpl: CoordinatorImpl, AppCoordinator {
    
    private let dashboardFactory: DashboardFactory
    
    init(
        navigationController: UINavigationController,
        dashboardFactory: DashboardFactory
    ) {
        self.dashboardFactory = dashboardFactory
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        dashboardFactory.coordinator.start()
    }
    
}
