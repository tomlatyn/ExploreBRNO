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
                    case .event(let event):
                        eventDetailView(event)
                    case .culturalPlace(let place):
                        culturalPlaceDetailView(place)
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
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        viewModel.selectedLocation = nil
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        viewModel.toggleBookmark(location.mapLocation)
                    }, label: {
                        Image(systemName: viewModel.isLocationBookmarked(location.mapLocation) ? "bookmark.fill" : "bookmark")
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
            
            let displayValue = value.trimmingCharacters(in: .whitespaces)
            let linkValue = displayValue.hasPrefix("www.") ? "https://\(displayValue)" : displayValue

            if let url = URL(string: linkValue), linkValue.hasPrefix("http") {
                Link(destination: url) {
                    Text(displayValue)
                        .multilineTextAlignment(.leading)
                }
            } else if value.isEmail, let emailUrl = URL(string: "mailto:\(value)") {
                Link(value, destination: emailUrl)
            } else if value.allSatisfy({ $0.isNumber || $0 == "+" }), let phoneUrl = URL(string: "tel:\(value)") {
                let formattedPhone = value.replacingOccurrences(of: "\\B(?=(\\d{3})+(?!\\d))", with: " ", options: .regularExpression)
                Link(formattedPhone, destination: phoneUrl)
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
    
    @ViewBuilder
    func detailImagesView(_ urls: [URL]) -> some View {
        if urls.count == 1, let url = urls.first {
            URLImageView(url: url)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(urls, id: \.self) { url in
                        URLImageView(url: url)
                            .frame(width: UIScreen.main.bounds.size.width * 0.83)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, -16)
        }
    }
}
