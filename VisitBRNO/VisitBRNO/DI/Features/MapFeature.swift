//
//  MapFeature.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI
import Swinject
import SwinjectAutoregistration

final class MapFeature: Assembly {
    func assemble(container: Container) {
        container.autoregister(MapCoordinator.self, initializer: MapCoordinatorImpl.init)
        container.autoregister(MapViewModel.self, initializer: MapViewModel.init)
        container.register(MapFactory.self, factory: MapFactoryImpl.init)
    }
}

final class MapFactoryImpl: MapFactory {
    // MARK: - Properties
    
    private let resolver: Resolver
    
    // MARK: - Lifecycle
    
    nonisolated init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    // MARK: - Resolving
    
    var coordinator: MapCoordinator {
        resolver.resolve(MapCoordinator.self)!
    }
    
    func resolveView() -> AnyView {
        AnyView(
            MapView(
                viewModel: resolver.resolve(MapViewModel.self)!,
                coordinator: coordinator
            )
        )
    }
}
