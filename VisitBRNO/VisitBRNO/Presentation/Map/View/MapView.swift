//
//  MapView.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI
import MapKit

public struct MapView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: MapViewModel
    let coordinator: MapCoordinator
    
    // MARK: - Lifecycle
    
    public init(
        viewModel: MapViewModel,
        coordinator: MapCoordinator
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
        UIMapView(viewModel: viewModel)
    }
}
