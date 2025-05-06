//
//  OnboardingCoordinatorImpl.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 07.05.2025.
//

import Foundation
import SwiftUI

final class OnboardingCoordinatorImpl: OnboardingCoordinator {
    
    // MARK: - Properties
    
    private let appCoordinator: AppCoordinator
    private let factory: OnboardingFactory
    
    // MARK: - Lifecycle
    
    nonisolated init(
        appCoordinator: AppCoordinator,
        factory: OnboardingFactory
    ) {
        self.appCoordinator = appCoordinator
        self.factory = factory
    }
    
    // MARK: - Navigation
    
    func start() {
        let vc = UIHostingController(rootView: factory.resolveView())
        appCoordinator.addOverlay(vc, transitionDuration: nil)
    }
    
    func navigate(_ path: OnboardingPath) {
        switch path {
        case .dismiss:
            appCoordinator.removeOverlay()
        }
    }
}
