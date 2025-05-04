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
        let latitude: CLLocationDegrees = location.mapLocation.model.coordinates.latitude
        let longitude: CLLocationDegrees = location.mapLocation.model.coordinates.longitude
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.mapLocation.model.name
        mapItem.openInMaps(launchOptions: options)
    }
}
