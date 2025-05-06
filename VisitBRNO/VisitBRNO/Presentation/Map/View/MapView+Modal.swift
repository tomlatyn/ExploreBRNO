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
                VStack(alignment: .leading, spacing: 16) {
                    locationNameView(location.mapLocation.model.name)
                    
                    Button("Open in maps") {
                        openInMaps(location: location)
                    }
                    .buttonStyle(.bordered)
                    
                    switch location.mapLocation {
                    case .viewpoint(let viewpoint):
                        viewpointDetailView(viewpoint)
                    case .landmark(let landmark):
                        landmarkDetailView(landmark)
                    case .event(let event):
                        eventDetailView(event)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
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
        }
    }
    
    private func locationNameView(_ name: String) -> some View {
        Text(name)
            .font(.largeTitle.weight(.semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func infoRowView(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: value), value.hasPrefix("http") {
                Link(destination: url) {
                    Text(url.absoluteString)
                        .multilineTextAlignment(.leading)
                }
            } else if value.contains("@"), let emailUrl = URL(string: "mailto:\(value)") {
                Link(value, destination: emailUrl)
            } else if value.allSatisfy({ $0.isNumber || $0 == "+" }), let phoneUrl = URL(string: "tel:\(value)") {
                Link(value, destination: phoneUrl)
            } else {
                Text(value)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
