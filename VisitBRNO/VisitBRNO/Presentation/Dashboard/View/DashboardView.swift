//
//  DashboardView.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI

public struct DashboardView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: DashboardViewModel
    let coordinator: DashboardCoordinator
    
    // MARK: - Lifecycle
    
    public init(
        viewModel: DashboardViewModel,
        coordinator: DashboardCoordinator
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
        .onAppear {
            viewModel.loadData()
        }
    }
    
    @ViewBuilder
    private var layoutMain: some View {
        Text("Dashboard")
    }
}
