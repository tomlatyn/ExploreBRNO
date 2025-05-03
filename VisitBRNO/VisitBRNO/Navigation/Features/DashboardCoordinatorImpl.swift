//
//  DashboardCoordinatorImpl.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI

final class DashboardCoordinatorImpl: DashboardCoordinator {
    
    // MARK: - Properties
    
    private let appCoordinator: AppCoordinator
    private let factory: DashboardFactory
    
    // MARK: - Lifecycle
    
    nonisolated init(
        appCoordinator: AppCoordinator,
        factory: DashboardFactory
    ) {
        self.appCoordinator = appCoordinator
        self.factory = factory
    }
    
    // MARK: - Navigation
    
    func start() {
        let vc = UIHostingController(rootView: factory.resolveView())
        appCoordinator.navigationController.pushViewController(vc, animated: false)
    }
    
    func navigate(_ path: DashboardPath) {
        switch path {
            
        }
    }
}
