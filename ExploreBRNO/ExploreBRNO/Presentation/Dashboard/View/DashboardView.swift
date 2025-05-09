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
//            Color(R.color.white()!)
//                .ignoresSafeArea()
            
            layoutMain
        }
    }
    
    @ViewBuilder
    private var layoutMain: some View {
        List {
            Text("All")
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    coordinator.navigate(.map(.all))
                }
            
            Text("Viewpoints")
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    coordinator.navigate(.map(.viewpoints))
                }
            
            Text("Events")
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    coordinator.navigate(.map(.events))
                }
            
            Text("Cultural Places")
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    coordinator.navigate(.map(.culturalPlaces))
                }
        }
    }
}
