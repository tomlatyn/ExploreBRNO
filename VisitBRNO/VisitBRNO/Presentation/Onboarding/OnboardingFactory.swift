//
//  OnboardingFactory.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 07.05.2025.
//

import Foundation
import SwiftUI

public protocol OnboardingFactory: AnyObject {
    @MainActor var coordinator: OnboardingCoordinator { get }
    @MainActor func resolveView() -> AnyView
}
