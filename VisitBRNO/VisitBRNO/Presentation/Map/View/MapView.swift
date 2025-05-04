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
            
            if viewModel.viewState == .loading {
                ProgressView()
                    .frame(width: 64, height: 64)
                    .background(
                        .thinMaterial
                    )
                    .cornerRadius(16)
            }
            
//            filterView
//                .frame(width: .infinity, height: .infinity, alignment: .topLeading)
        }
        .onAppear {
            viewModel.loadData()
        }
        .sheet(item: $viewModel.selectedLocation) { location in
            selectedLocationView(location: location)
        }
        .animation(.default, value: viewModel.viewState)
        .onChange(of: viewModel.viewState) { _, state in
            switch state {
            case .connectionError:
                print("connection error")
            case .generalError:
                print("general error")
            default:
                break
            }
        }
    }
    
    @ViewBuilder
    private var layoutMain: some View {
        UIMapView(
            viewModel: viewModel,
            mapLocations: viewModel.filteredMapLocations,
            showSelectionList: { annotations in
                print(annotations.map { $0.title })
            }
        )
            .ignoresSafeArea(edges: [.bottom])
    }
    
    private var filterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.mapLocationTypes, id: \.self) { type in
                    Text(type.collectionName)
                        .padding(12)
                        .background(viewModel.selectedMapLocationTypes.contains(type) ? Color.white : Color.gray)
                        .clipShape(.capsule)
                        .onTapGesture {
                            viewModel.toggleMapLocationType(type: type)
                        }
                }
            }
            .padding(12)
        }
    }
}
