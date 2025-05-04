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
    @State var locations = [LocationAnnotation]()
    @State var isPresented = false
    @State var height: CGFloat = 0
    
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
            
            Color.clear
                .frame(width: 1, height: 1)
                .popover(isPresented: $isPresented, arrowEdge: .top) {
                    clusterList
                        .presentationSizing(.fitted)
                        .presentationCompactAdaptation(.popover)
                }
            
            
//            filterView
//                .frame(width: .infinity, height: .infinity, alignment: .topLeading)
        }
        .onAppear {
            viewModel.loadData()
        }
        .animation(.default, value: isPresented)
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
                self.locations = annotations
                isPresented = true
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
    
    private var clusterList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(locations, id: \.location.id) { location in
                    HStack {
                        Text(location.location.model.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "chevron.right")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isPresented = false
                        viewModel.selectLocation(location.location)
                    }
                    
                    if location != locations.last {
                        Divider()
                    }
                }
            }
            .padding(16)
        }
    }
}
