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
    private let mapFactory: MapFactory
    
    // MARK: - Lifecycle
    
    nonisolated init(
        appCoordinator: AppCoordinator,
        factory: DashboardFactory,
        mapFactory: MapFactory
    ) {
        self.appCoordinator = appCoordinator
        self.factory = factory
        self.mapFactory = mapFactory
    }
    
    // MARK: - Navigation
    
    func start() {
        let vc = UIHostingController(rootView: factory.resolveView())
        vc.title = R.string.localizable.app_name()
        vc.navigationItem.largeTitleDisplayMode = .always
        appCoordinator.navigationController.navigationBar.prefersLargeTitles = true
        appCoordinator.navigationController.pushViewController(vc, animated: false)
    }
    
    func navigate(_ path: DashboardPath) {
        switch path {
        case .map(let type):
            mapFactory.coordinator.start(type)
        }
    }
}
