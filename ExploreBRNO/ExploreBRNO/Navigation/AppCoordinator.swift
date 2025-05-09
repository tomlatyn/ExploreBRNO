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

// MARK: - Class

final class AppCoordinatorImpl: CoordinatorImpl, AppCoordinator {
    
    // MARK: - Properties
    
    private let dashboardFactory: DashboardFactory
    private let onboardingFactory: OnboardingFactory
    private let onboardingRepository: OnboardingRepository
    
    // MARK: - Lifecycle
    
    init(
        navigationController: UINavigationController,
        dashboardFactory: DashboardFactory,
        onboardingFactory: OnboardingFactory,
        onboardingRepository: OnboardingRepository
    ) {
        self.dashboardFactory = dashboardFactory
        self.onboardingFactory = onboardingFactory
        self.onboardingRepository = onboardingRepository
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Implementation
    
    override func start() {
        startWithDashboard()
        if !onboardingRepository.isOnboardingSeen {
            showOnboarding()
        }
    }
    
    private func showOnboarding() {
        onboardingFactory.coordinator.start()
    }
    
    private func startWithDashboard() {
        dashboardFactory.coordinator.start()
    }
    
}
