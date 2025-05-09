//
//  DashboardFeature.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI
import Swinject
import SwinjectAutoregistration

final class DashboardFeature: Assembly {
    func assemble(container: Container) {
        container.autoregister(DashboardCoordinator.self, initializer: DashboardCoordinatorImpl.init)
        container.autoregister(DashboardViewModel.self, initializer: DashboardViewModel.init)
        container.register(DashboardFactory.self, factory: DashboardFactoryImpl.init)
    }
}

final class DashboardFactoryImpl: DashboardFactory {
    // MARK: - Properties
    
    private let resolver: Resolver
    
    // MARK: - Lifecycle
    
    nonisolated init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    // MARK: - Resolving
    
    var coordinator: DashboardCoordinator {
        resolver.resolve(DashboardCoordinator.self)!
    }
    
    func resolveView() -> AnyView {
        AnyView(
            DashboardView(
                viewModel: resolver.resolve(DashboardViewModel.self)!,
                coordinator: coordinator
            )
        )
    }
}
