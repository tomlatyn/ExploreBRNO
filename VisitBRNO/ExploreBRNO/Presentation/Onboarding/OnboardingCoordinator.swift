//
//  OnboardingCoordinator.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 07.05.2025.
//

import Foundation

public enum OnboardingPath {
    case dismiss
}

public protocol OnboardingCoordinator: AnyObject {
    @MainActor func start()
    @MainActor func navigate(_ path: OnboardingPath)
}
