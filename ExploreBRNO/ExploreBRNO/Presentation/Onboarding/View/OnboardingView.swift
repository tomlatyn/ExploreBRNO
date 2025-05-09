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
            Color(R.color.background()!)
                .ignoresSafeArea()
            
            layoutMain
        }
    }
    
    @ViewBuilder
    private var layoutMain: some View {
        VStack(spacing: Padding.pt32) {
            Text(R.string.localizable.onboarding_title())
                .font(.largeTitle.weight(.semibold))
            
            screenshotView
            
            Text(R.string.localizable.onboarding_text())
                .font(.body)
            
            ButtonLarge(text: R.string.localizable.onboarding_button()) {
                coordinator.navigate(.dismiss)
            }
        }
        .multilineTextAlignment(.center)
        .padding(Padding.pt16)
        .frame(maxWidth: 332)
    }
    
    private var screenshotView: some View {
        Image(uiImage: R.image.map_screenshot()!)
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 300)
            .clipped()
            .cornerRadius(CornerRadius.pt16)
    }
}
