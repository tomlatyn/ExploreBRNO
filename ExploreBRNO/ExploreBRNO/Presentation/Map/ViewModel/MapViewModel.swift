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
    
    private let mapRepository: MapRepository
    let mapType: MapType
    private let locationManager = CLLocationManager()
    
    // MARK: - Published properties
    
    @Published var viewState = BaseViewState.loading {
        didSet {
            onViewStateChange(viewState)
        }
    }
    @Published var mapLocations = [MapLocation]()
    @Published var selectedMapLocationTypes: [MapLocationType] = MapLocationType.allCases
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published private(set) var selectedLocation: SelectedLocation? {
        didSet {
            if selectedLocation == nil {
                presentationDetent = .medium
            }
        }
    }
    @Published var presentationDetent: PresentationDetent = .medium
    @Published var presentedAlert: PresentedAlert?
    @Published var bookmarkedLocationIds = [String]()
    @Published var bookmarkFilterToggle = false
    @Published var clusterLocations = [LocationAnnotation]()
    @Published var isClusterListPresented = false
    @Published var isFilterPresented = false
    
    // MARK: - Lifecycle
    
    public nonisolated init(
        mapType: MapType,
        combinedRepository: MapRepository
    ) {
        self.mapType = mapType
        self.mapRepository = combinedRepository
        
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Fetching data
    
    @MainActor
    func loadData() {
        guard viewState != .ok else { return }
        viewState = .loading
        Task {
            self.bookmarkedLocationIds = mapRepository.getBookmarkedLocations()
            viewState = await .newViewState {
                self.mapLocations = try await getMapLocations()
            }
        }
    }
    
    private func getMapLocations() async throws -> [MapLocation] {
        var mapLocations = [MapLocation]()
        switch mapType {
        case .all:
            async let viewpoints = mapRepository.getViewpoints()
            async let events = mapRepository.getEvents()
            async let culturalPlaces = mapRepository.getCulturalPlaces()
            mapLocations += try await viewpoints.map { MapLocation.viewpoint($0) }
            mapLocations += try await events.map { MapLocation.event($0) }
            mapLocations += try await culturalPlaces.map { MapLocation.culturalPlace($0) }
        case .viewpoints:
            mapLocations = try await mapRepository.getViewpoints().map { MapLocation.viewpoint($0) }
        case .events:
            mapLocations = try await mapRepository.getEvents().map { MapLocation.event($0) }
        case .culturalPlaces:
            mapLocations = try await mapRepository.getCulturalPlaces().map { MapLocation.culturalPlace($0) }
        }
        return mapLocations
    }
    
    // MARK: - Location selection
    
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
    
    // MARK: - Map filter
    
    var filteredMapLocations: [MapLocation] {
        mapLocations.filter { location in
            selectedMapLocationTypes.contains(location.type) &&
            (bookmarkFilterToggle ? isLocationBookmarked(location) : true)
        }
    }
    
    var mapLocationTypes: [MapLocationType] {
        Array(Set(mapLocations.map { $0.type })).sorted(by: { $0.name < $1.name })
    }
    
    func toggleMapLocationType(type: MapLocationType) {
        if selectedMapLocationTypes.contains(type) {
            selectedMapLocationTypes.removeAll(where: { $0 == type })
        } else {
            selectedMapLocationTypes.append(type)
        }
    }
    
    // MARK: - Bookmarks
    
    func isLocationBookmarked(_ location: MapLocation) -> Bool {
        return bookmarkedLocationIds.contains(location.id)
    }
    
    func toggleBookmark(_ location: MapLocation) {
        mapRepository.updateLocationBookmark(id: location.id, bookmarked: !isLocationBookmarked(location))
        self.bookmarkedLocationIds = mapRepository.getBookmarkedLocations()
    }
    
    // MARK: - Helper functions
    
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
