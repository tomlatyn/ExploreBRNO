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
    @State var filter = false
    
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
            
            mapView
            
            if viewModel.viewState == .loading {
                LoadingView()
            }
            
            Color.clear
                .frame(width: 1, height: 1)
                .popover(isPresented: $isPresented, arrowEdge: .top) {
                    clusterList
                        .presentationSizing(.fitted)
                        .presentationCompactAdaptation(.popover)
                }
            
            closestLocationButton
            
            mapOverlay
        }
        .onAppear {
            viewModel.loadData()
        }
        .animation(.default, value: isPresented)
        .sheet(isPresented: .constant(viewModel.selectedLocation != nil)) {
            if let location = viewModel.selectedLocation {
                selectedLocationView(location: location)
            }
        }
        .disabled(viewModel.viewState == .loading)
        .animation(.default, value: viewModel.viewState)
        .alert(item: $viewModel.presentedAlert) { alert in
            switch alert.id {
            case .connectionError:
                Alerts.connectionErrorAlert(
                    onRetry: viewModel.loadData,
                    onCancel: { coordinator.navigate(.pop) }
                )
            case .generalError:
                Alerts.generalErrorAlert(
                    onRetry: viewModel.loadData,
                    onCancel: { coordinator.navigate(.pop) }
                )
            case .locationError:
                locationErrorAlert
            }
        }
    }
    
    @ViewBuilder
    private var mapView: some View {
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
        VStack(spacing: 12) {
            Toggle("Only bookmarked", isOn: $viewModel.bookmarkFilterToggle)
            
            Divider()
            
            VStack(spacing: 12) {
                ForEach(viewModel.mapLocationTypes, id: \.self) { type in
                    Text(type.collectionName)
                        .foregroundStyle(.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(Color(type.color))
                        .opacity(viewModel.selectedMapLocationTypes.contains(type) ? 1 : 0.35)
                        .clipShape(.capsule)
                        .onTapGesture {
                            viewModel.toggleMapLocationType(type: type)
                        }
                }
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding(12)
    }
    
    private var closestLocationButton: some View {
        Button("Find closest location") {
            viewModel.selectClosestLocation()
        }
        .buttonStyle(.bordered)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 12)
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
    
    private var mapOverlay: some View {
        VStack(spacing: 8) {
            Button(action: {
                viewModel.focusOnUserLocation()
            }, label: {
                Image(systemName: "location")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(12)
                    .background(.white.opacity(0.8))
                    .cornerRadius(6)
            })
            
            Button(action: {
                filter = true
            }, label: {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(12)
                    .background(.white.opacity(0.8))
                    .cornerRadius(6)
            })
            .popover(isPresented: $filter) {
                filterView
                    .presentationSizing(.fitted)
                    .presentationCompactAdaptation(.popover)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
    
    private var locationErrorAlert: Alert {
        Alert(
            title: Text("Location Not Available"),
            message: Text("We couldn't access your current location. Please make sure location services are enabled in Settings."),
            primaryButton: .default(Text("Open Settings")) {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                }
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }
}
