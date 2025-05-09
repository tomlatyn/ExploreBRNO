//
//  OnboardingFeature.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 07.05.2025.
//

import Foundation
import SwiftUI
import Swinject
import SwinjectAutoregistration

final class OnboardingFeature: Assembly {
    func assemble(container: Container) {
        container.autoregister(OnboardingCoordinator.self, initializer: OnboardingCoordinatorImpl.init)
        container.autoregister(OnboardingViewModel.self, initializer: OnboardingViewModel.init)
        container.register(OnboardingFactory.self, factory: OnboardingFactoryImpl.init)
    }
}

final class OnboardingFactoryImpl: OnboardingFactory {
    // MARK: - Properties
    
    private let resolver: Resolver
    
    // MARK: - Lifecycle
    
    nonisolated init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    // MARK: - Resolving
    
    var coordinator: OnboardingCoordinator {
        resolver.resolve(OnboardingCoordinator.self)!
    }
    
    func resolveView() -> AnyView {
        AnyView(
            OnboardingView(
                viewModel: resolver.resolve(OnboardingViewModel.self)!,
                coordinator: coordinator
            )
        )
    }
}
