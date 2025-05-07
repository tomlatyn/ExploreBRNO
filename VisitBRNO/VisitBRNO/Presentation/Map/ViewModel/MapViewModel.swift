//
//  MapViewModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI
import MapKit

public final class MapViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    private let combinedRepository: MapRepository
    private let mapType: MapType
    private let locationManager = CLLocationManager()
    
    // MARK: - Published properties
    
    @Published var viewState = BaseViewState.loading {
        didSet {
            onViewStateChange(viewState)
        }
    }
    @Published var mapLocations = [MapLocation]()
    @Published var selectedMapLocationTypes: [MapLocation.LocationType] = MapLocation.LocationType.allCases
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var region = Constants.defaultMapRegion
    @Published var selectedLocation: SelectedLocation? {
        didSet {
            if selectedLocation == nil {
                presentationDetent = .medium
            }
        }
    }
    @Published var presentationDetent: PresentationDetent = .medium
    @Published var presentedAlert: PresentedAlert?
    
    
    // MARK: - Lifecycle
    
    public nonisolated init(
        mapType: MapType,
        combinedRepository: MapRepository
    ) {
        self.mapType = mapType
        self.combinedRepository = combinedRepository
        
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: -

    
    @MainActor
    func loadData() {
        guard viewState != .ok else { return }
        viewState = .loading
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
            async let events = combinedRepository.getEvents()
            mapLocations += try await viewpoints.map { MapLocation.viewpoint($0) }
            mapLocations += try await landmarks.map { MapLocation.landmark($0) }
            mapLocations += try await events.map { MapLocation.event($0) }
        case .landmarks:
            mapLocations = try await combinedRepository.getLandmarks().map { MapLocation.landmark($0) }
        case .viewpoints:
            mapLocations = try await combinedRepository.getViewpoints().map { MapLocation.viewpoint($0) }
        case .events:
            mapLocations = try await combinedRepository.getEvents().map { MapLocation.event($0) }
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

    func selectClosestLocation() {
        guard let userLocation = userLocation else {
            presentedAlert = PresentedAlert(.locationError)
            return
        }
        let userLocationCl = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        selectLocation(filteredMapLocations.min(by: {
            let loc1 = CLLocation(latitude: $0.model.coordinates.latitude, longitude: $0.model.coordinates.longitude)
            let loc2 = CLLocation(latitude: $1.model.coordinates.latitude, longitude: $1.model.coordinates.longitude)
            return loc1.distance(from: userLocationCl) < loc2.distance(from: userLocationCl)
        }))
    }
    
    var mapLocationTypes: [MapLocation.LocationType] {
        Array(Set(mapLocations.map { $0.type })).sorted(by: { $0.name < $1.name })
    }
    
    func toggleMapLocationType(type: MapLocation.LocationType) {
        if selectedMapLocationTypes.contains(type) {
            selectedMapLocationTypes.removeAll(where: { $0 == type })
        } else {
            selectedMapLocationTypes.append(type)
        }
    }
    
    var filteredMapLocations: [MapLocation] {
        mapLocations.filter { location in
            selectedMapLocationTypes.contains(location.type)
        }
    }
    
    func focusOnUserLocation() {
        guard let userLocation = userLocation else {
            presentedAlert = PresentedAlert(.locationError)
            return
        }
        region = MKCoordinateRegion(
            center: userLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    }
    
    private func onViewStateChange(_ viewState: BaseViewState) {
        switch viewState {
        case .generalError:
            presentedAlert = PresentedAlert(.generalError)
        case .connectionError:
            presentedAlert = PresentedAlert(.connectionError)
        default:
            break
        }
    }
    
}

// MARK: - Extension

extension MapViewModel {
    struct SelectedLocation: Identifiable {
        var id: String
        var mapLocation: MapLocation
    }
    
    struct PresentedAlert: Identifiable {
        enum Alert {
            case connectionError
            case generalError
            case locationError
        }
        
        var id: Alert
        
        init(_ id: Alert) {
            self.id = id
        }
    }
    
}
