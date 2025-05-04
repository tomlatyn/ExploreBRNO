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
    
    var locationManager = CLLocationManager()
    
    // MARK: - Published properties
    
    @Published var viewState = BaseViewState.loading
    @Published var region = MapConstants.defaultMapRegion
    @Published var selectedLocation: SelectedLocation?
    @Published var presentationDetent: PresentationDetent = .medium
    @Published var mapLocations = [MapLocation]()
    
    // MARK: - Lifecycle
    
    public nonisolated init(
        combinedRepository: CombinedRepository
    ) {
        self.combinedRepository = combinedRepository
        
        setupLocationManager()
    }
    
    // MARK: -
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    @MainActor
    func loadData() {
        Task {
            viewState = await .newViewState {
                async let viewpoints = combinedRepository.getViewpoints()
                async let landmarks = combinedRepository.getLandmarks()
                self.mapLocations += try await viewpoints.map { MapLocation.viewpoint($0) }
                self.mapLocations += try await landmarks.map { MapLocation.landmark($0) }
            }
        }
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
        }
    }
    
    
    
}

extension MapViewModel {
    struct SelectedLocation: Identifiable {
        var id: Int
        var mapLocation: MapLocation
    }
}
