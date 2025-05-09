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
            
            mapView
            
            if viewModel.viewState == .loading {
                LoadingView(text: viewModel.mapType.loadingText)
            }
            
            clusterListPopover
            
            closestLocationButton
        }
        .onAppear {
            viewModel.loadData()
        }
        .animation(.default, value: viewModel.viewState)
        .disabled(viewModel.viewState == .loading)
        .sheet(isPresented: .constant(viewModel.selectedLocation != nil)) {
            if let location = viewModel.selectedLocation {
                selectedLocationView(location: location)
            }
        }
        .alert(item: $viewModel.presentedAlert) { alert in
            getAlert(alert: alert)
        }
        .toolbar {
            toolbarContent
        }
    }
    
    @ViewBuilder
    private var mapView: some View {
        UIMapView(
            viewModel: viewModel,
            mapLocations: viewModel.filteredMapLocations,
            showSelectionList: { locations in
                viewModel.clusterLocations = locations
                viewModel.isClusterListPresented = true
            }
        )
        .ignoresSafeArea(edges: [.bottom])
    }
    
    // MARK: - Toolbar
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button(action: {
                viewModel.isFilterPresented = true
            }, label: {
                Image(systemName: "slider.horizontal.3")
            })
            .popover(isPresented: $viewModel.isFilterPresented) {
                mapFilterView
                    .presentationSizing(.fitted)
                    .presentationCompactAdaptation(.popover)
            }
            .disabled(viewModel.viewState == .loading)
        }
    }
    
    // MARK: - Alert
    
    private func getAlert(alert: MapViewModel.PresentedAlert) -> Alert {
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
    
    private var locationErrorAlert: Alert {
        Alert(
            title: Text(R.string.localizable.alert_location_error_title()),
            message: Text(R.string.localizable.alert_location_error_message),
            primaryButton: .default(Text(R.string.localizable.alert_location_error_primary)) {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                }
            },
            secondaryButton: .cancel()
        )
    }
}
