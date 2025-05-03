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
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.19492956343889, longitude: 16.608378039964823),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @Published var selectedLocation: ViewpointModel? {
        didSet {
            print(selectedLocation)
        }
    }
    @Published var viewpoints = [ViewpointModel]()
    
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
            if let viewpoints = try? await combinedRepository.getViewpoints() {
                self.viewpoints = viewpoints
            }
        }
    }
    
    func selectLocation(_ location: ViewpointModel?) {
        DispatchQueue.main.async { [weak self] in
            self?.selectedLocation = location
        }
    }
    
}
