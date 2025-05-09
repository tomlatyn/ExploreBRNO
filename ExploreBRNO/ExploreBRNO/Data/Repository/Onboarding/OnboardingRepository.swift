//
//  OnboardingRepository.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 06.05.2025.
//

import Foundation

public protocol OnboardingRepository: AnyObject {
    var isOnboardingSeen: Bool { get set }
}

public class OnboardingRepositoryImpl: OnboardingRepository {
    
    // MARK: - Instance properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    
    public init() {
        self.isOnboardingSeen = userDefaults.bool(forKey: UserDefaultsKeys.isOnboardingSeen.rawValue)
    }
    
    // MARK: - Public properties
    
    public var isOnboardingSeen: Bool {
        didSet {
            userDefaults.set(isOnboardingSeen, forKey: UserDefaultsKeys.isOnboardingSeen.rawValue)
        }
    }
    
}
