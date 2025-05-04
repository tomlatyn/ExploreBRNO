//
//  MapView+Modal.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import SwiftUI
import MapKit

extension MapView {
    
    func selectedLocationView(location: MapViewModel.SelectedLocation) -> some View {
        NavigationStack {
            ScrollView {
                Button("Open in maps") {
                    openInMaps(location: location)
                }
                .buttonStyle(.bordered)
                
                switch location.mapLocation {
                case .viewpoint(let viewpoint):
                    Text("viewpoint")
                    Text("Altitude: \(NSString(format: "%.01f", viewpoint.altitude)) meters")
                case .landmark(let landmark):
                    Text("landmark")
                case .event(let event):
                    eventDetailView(event)
                }
            }
            .presentationDetents([.height(100), .medium, .large], selection: $viewModel.presentationDetent)
            .presentationDragIndicator(.visible)
            .presentationBackground(.thinMaterial)
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        viewModel.selectedLocation = nil
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                }
            }
            .navigationTitle(location.mapLocation.model.name)
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func openInMaps(location: MapViewModel.SelectedLocation) {
        let coordinates = CLLocationCoordinate2D(
            latitude: location.mapLocation.model.coordinates.latitude,
            longitude: location.mapLocation.model.coordinates.longitude
        )
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        let options: [String: Any] = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)
        ]
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
        mapItem.name = location.mapLocation.model.name
        mapItem.openInMaps(launchOptions: options)
    }
}
