//
//  OnboardingView.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 07.05.2025.
//

import Foundation
import SwiftUI

public struct OnboardingView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: OnboardingViewModel
    private let coordinator: OnboardingCoordinator
    
    // MARK: - Lifecycle
    
    public init(
        viewModel: OnboardingViewModel,
        coordinator: OnboardingCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    // MARK: - Layout
    
    public var body: some View {
        ZStack {
//            Color(R.color.background.default()!)
//                .ignoresSafeArea()
            
            layoutMain
        }
    }
    
    @ViewBuilder
    private var layoutMain: some View {
        VStack {
            Text("Onboarding")
            
            Button("Dismiss") {
                coordinator.navigate(.dismiss)
            }
        }
    }
}
