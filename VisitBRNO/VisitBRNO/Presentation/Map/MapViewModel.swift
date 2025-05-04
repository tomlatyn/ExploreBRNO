//
//  MapViewModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI
import MapKit

public final class MapViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let combinedRepository: CombinedRepository
    private let mapType: MapType
    
    // MARK: - Published properties
    
    @Published var viewState = BaseViewState.loading
    @Published var mapLocations = [MapLocation]()
    
    @Published var region = MapConstants.defaultMapRegion
    @Published var selectedLocation: SelectedLocation? {
        didSet {
            if selectedLocation == nil {
                presentationDetent = .medium
            }
        }
    }
    @Published var presentationDetent: PresentationDetent = .medium
    
    
    // MARK: - Lifecycle
    
    public nonisolated init(
        mapType: MapType,
        combinedRepository: CombinedRepository
    ) {
        self.mapType = mapType
        self.combinedRepository = combinedRepository
        
        CLLocationManager().requestWhenInUseAuthorization()
    }
    
    // MARK: -
    
    @MainActor
    func loadData() {
        Task {
            viewState = await .newViewState {
                self.mapLocations = try await getMapLocations()
            }
        }
    }
    
    private func getMapLocations() async throws -> [MapLocation] {
        var mapLocations = [MapLocation]()
        switch mapType {
        case .all:
            async let viewpoints = combinedRepository.getViewpoints()
            async let landmarks = combinedRepository.getLandmarks()
            mapLocations += try await viewpoints.map { MapLocation.viewpoint($0) }
            mapLocations += try await landmarks.map { MapLocation.landmark($0) }
        case .landmarks:
            mapLocations = try await combinedRepository.getLandmarks().map { MapLocation.landmark($0) }
        case .viewpoints:
            mapLocations = try await combinedRepository.getViewpoints().map { MapLocation.viewpoint($0) }
        }
        return mapLocations
    }
    
    func selectLocation(_ location: MapLocation?) {
        DispatchQueue.main.async { [weak self] in
            guard let location = location else {
                self?.selectedLocation = nil
                return
            }
            self?.selectedLocation = SelectedLocation(
                id: location.model.id,
                mapLocation: location
            )
            self?.focusLocation(coordinates: location.model.coordinates)
        }
    }
    
    private func focusLocation(coordinates: CLLocationCoordinate2D) {
        let adjustedCoordinates = CLLocationCoordinate2D(
            latitude: coordinates.latitude - 0.004,
            longitude: coordinates.longitude
        )
        self.region = MKCoordinateRegion(
            center: adjustedCoordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    }
    
}

// MARK: - Extension

extension MapViewModel {
    struct SelectedLocation: Identifiable {
        var id: Int
        var mapLocation: MapLocation
    }
}
