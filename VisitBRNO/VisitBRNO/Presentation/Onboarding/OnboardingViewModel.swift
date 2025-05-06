//
//  OnboardingViewModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 07.05.2025.
//

import Foundation

public final class OnboardingViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let onboardingRepository: OnboardingRepository
    
    // MARK: - Published properties
    
    // MARK: - Lifecycle
    
    public nonisolated init(
        onboardingRepository: OnboardingRepository
    ) {
        self.onboardingRepository = onboardingRepository
    }
    
    // MARK: -
    
    func setOnboardingAsSeen() {
        onboardingRepository.isOnboardingSeen = true
    }
    
}
