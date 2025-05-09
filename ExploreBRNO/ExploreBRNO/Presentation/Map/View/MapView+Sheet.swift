//
//  MapView+Sheet.swift
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
                VStack(alignment: .leading, spacing: Padding.pt16) {
                    locationNameView(location.mapLocation.model.name)
                    
                    navigateToLocationButton(location.mapLocation)
                    
                    switch location.mapLocation {
                    case .viewpoint(let viewpoint):
                        viewpointDetailView(viewpoint)
                    case .event(let event):
                        eventDetailView(event)
                    case .culturalPlace(let place):
                        culturalPlaceDetailView(place)
                    }
                }
                .padding(.horizontal, Padding.pt16)
                .padding(.bottom, Padding.pt24)
            }
            .presentationDetents([.height(100), .medium, .large], selection: $viewModel.presentationDetent)
            .presentationDragIndicator(.visible)
            .presentationBackground(.thinMaterial)
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        viewModel.selectLocation(nil)
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
    
    private func navigateToLocationButton(_ location: MapLocation) -> some View {
        Button(action: {
            openLocationInMaps(location: location)
        }, label: {
            HStack(spacing: Padding.pt8) {
                Image(systemName: "location.north.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12)
                
                Text(R.string.localizable.map_navigate_to_location())
            }
        })
        .buttonStyle(.bordered)
    }
    
    // MARK: - Reusable views
    
    func infoRowView(_ title: String, _ value: String, type: InfoRowType) -> some View {
        VStack(alignment: .leading, spacing: Padding.pt4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        
            let value = value.trimmingCharacters(in: .whitespacesAndNewlines)
            switch type {
            case .text:
                Text(value)
            case .link:
                let linkValue = value.hasPrefix("www.") ? "https://\(value)" : value
                if let url = URL(string: linkValue), linkValue.hasPrefix("http") {
                    Link(destination: url) {
                        Text(linkValue)
                            .multilineTextAlignment(.leading)
                    }
                } else {
                    Text(value)
                }
            case .email:
                if let emailUrl = URL(string: "mailto:\(value)") {
                    Link(destination: emailUrl) {
                        Text(value)
                            .multilineTextAlignment(.leading)
                    }
                } else {
                    Text(value)
                }
            case .phone:
                if let phoneUrl = URL(string: "tel:\(value)") {
                    let formattedPhone = value.replacingOccurrences(of: "\\B(?=(\\d{3})+(?!\\d))", with: " ", options: .regularExpression)
                    Link(formattedPhone, destination: phoneUrl)
                } else {
                    Text(value)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    enum InfoRowType {
        case text
        case link
        case email
        case phone
    }
    
    @ViewBuilder
    func detailImagesView(_ urls: [URL]) -> some View {
        if urls.count == 1, let url = urls.first {
            URLImageView(url: url)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Padding.pt12) {
                    ForEach(urls, id: \.self) { url in
                        URLImageView(url: url)
                            .frame(width: UIScreen.main.bounds.size.width * 0.83)
                    }
                }
                .padding(.horizontal, Padding.pt16)
            }
            .padding(.horizontal, -Padding.pt16)
        }
    }
    
    // MARK: - Helper functions
    
    private func openLocationInMaps(location: MapLocation) {
        let coordinates = CLLocationCoordinate2D(
            latitude: location.model.coordinates.latitude,
            longitude: location.model.coordinates.longitude
        )
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        let options: [String: Any] = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)
        ]
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
        mapItem.name = location.model.name
        mapItem.openInMaps(launchOptions: options)
    }
    
}
