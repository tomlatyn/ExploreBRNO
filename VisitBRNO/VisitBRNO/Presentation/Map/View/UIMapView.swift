//
//  UIMapView.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import UIKit
import SwiftUI
import MapKit

struct UIMapView: UIViewRepresentable {
    @ObservedObject var viewModel: MapViewModel
    private let locationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Register reusable annotation views - important for memory management
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "LocationPin")
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "cluster")
        
        // Set up map features
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        
        setupUserTrackingButtonAndScaleView(mapView: mapView)
        
        // Set initial region
        mapView.setRegion(viewModel.region, animated: false)
        
        // Request location permissions
        locationManager.requestWhenInUseAuthorization()
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // Optimize annotation updates by checking if data actually changed
        if shouldUpdateAnnotations(on: mapView) {
            updateAnnotations(on: mapView)
        }
        
        // Handle selected location
        updateSelectedLocation(on: mapView, context: context)
        
        if mapView.region.center.latitude != viewModel.region.center.latitude ||
            mapView.region.center.longitude != viewModel.region.center.longitude {
            mapView.setRegion(viewModel.region, animated: true)
        }
    }
    
    private func shouldUpdateAnnotations(on mapView: MKMapView) -> Bool {
        let currentAnnotations = mapView.annotations.compactMap { $0 as? LocationAnnotation }
        let currentIDs = Set(currentAnnotations.map { $0.location.id })
        let newIDs = Set(viewModel.mapLocations.map { $0.id })
        
        return currentIDs != newIDs || currentAnnotations.count != viewModel.mapLocations.count
    }
    
    private func updateAnnotations(on mapView: MKMapView) {
        // Create a dictionary of existing annotations by ID for efficient lookup
        let existingAnnotations: [Int: LocationAnnotation] = Dictionary(
            uniqueKeysWithValues: mapView.annotations.compactMap { annotation -> (Int, LocationAnnotation)? in
                if let locationAnnotation = annotation as? LocationAnnotation {
                    return (locationAnnotation.location.id, locationAnnotation)
                }
                return nil
            }
        )
        
        // Determine which annotations to add and remove
        let annotationsToRemove = mapView.annotations.filter { annotation in
            if annotation is MKUserLocation { return false }
            
            if let locationAnnotation = annotation as? LocationAnnotation {
                return !viewModel.mapLocations.contains { $0.id == locationAnnotation.location.id }
            }
            
            return true
        }
        
        let annotationsToAdd = viewModel.mapLocations.compactMap { location -> LocationAnnotation? in
            if existingAnnotations[location.id] == nil {
                return LocationAnnotation(location: location)
            }
            return nil
        }
        
        // Only remove/add what's needed
        if !annotationsToRemove.isEmpty {
            mapView.removeAnnotations(annotationsToRemove)
        }
        
        if !annotationsToAdd.isEmpty {
            mapView.addAnnotations(annotationsToAdd)
        }
    }
    
    private func updateSelectedLocation(on mapView: MKMapView, context: Context) {
        if let selectedLocation = viewModel.selectedLocation {
            // Find the annotation that corresponds to the selected location
            if let annotation = mapView.annotations.compactMap({ $0 as? LocationAnnotation })
                .first(where: { $0.location.id == selectedLocation.id }) {
                
                // Select the annotation if it's not already selected
                let isSelected = mapView.selectedAnnotations.contains {
                    ($0 as? LocationAnnotation)?.location.id == selectedLocation.id
                }
                
                if !isSelected {
                    mapView.selectAnnotation(annotation, animated: true)
                }
                
                // Update the annotation color if view exists
                if let annotationView = mapView.view(for: annotation) as? MKMarkerAnnotationView {
                    annotationView.markerTintColor = .systemRed
                }
            }
        } else {
            // Deselect all annotations if there's no selected location
            mapView.selectedAnnotations.forEach { mapView.deselectAnnotation($0, animated: false) }
        }
    }
    
    func makeCoordinator() -> UIMapViewCoordinator {
        UIMapViewCoordinator(self)
    }
    
    func setupUserTrackingButtonAndScaleView(mapView: MKMapView) {
        let button = MKUserTrackingButton(mapView: mapView)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(button)
        
        let scale = MKScaleView(mapView: mapView)
        scale.legendAlignment = .trailing
        scale.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(scale)
        
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 10),
                                     button.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
                                     scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
                                     scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
    }
}
