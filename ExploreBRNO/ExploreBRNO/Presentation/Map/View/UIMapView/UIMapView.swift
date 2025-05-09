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
    var mapLocations: [MapLocation]
    var showSelectionList: ([LocationAnnotation]) -> Void
    private let locationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "LocationPin")
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "cluster")
        
        setupUserTrackingButtonAndCompass(mapView: mapView)
        
        mapView.setRegion(Constants.defaultMapRegion, animated: false)
        mapView.pointOfInterestFilter = .excludingAll
        
        locationManager.requestWhenInUseAuthorization()
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if shouldUpdateAnnotations(on: mapView) {
            updateAnnotations(on: mapView)
        }
        
        updateSelectedLocation(on: mapView, context: context)
    }
    
    private func shouldUpdateAnnotations(on mapView: MKMapView) -> Bool {
        let currentAnnotations = mapView.annotations.compactMap { $0 as? LocationAnnotation }
        let currentIDs = Set(currentAnnotations.map { $0.location.id })
        let newIDs = Set(mapLocations.map { $0.id })
        
        return currentIDs != newIDs || currentAnnotations.count != mapLocations.count
    }
    
    private func updateAnnotations(on mapView: MKMapView) {
        let existingAnnotations: [String: LocationAnnotation] = Dictionary(
            uniqueKeysWithValues: mapView.annotations.compactMap { annotation -> (String, LocationAnnotation)? in
                if let locationAnnotation = annotation as? LocationAnnotation {
                    return (locationAnnotation.location.id, locationAnnotation)
                }
                return nil
            }
        )
        
        let annotationsToRemove = mapView.annotations.filter { annotation in
            if annotation is MKUserLocation { return false }
            
            if let locationAnnotation = annotation as? LocationAnnotation {
                return !mapLocations.contains { $0.id == locationAnnotation.location.id }
            }
            
            return true
        }
        
        let annotationsToAdd = mapLocations.compactMap { location -> LocationAnnotation? in
            if existingAnnotations[location.id] == nil {
                return LocationAnnotation(location: location)
            }
            return nil
        }
        
        if !annotationsToRemove.isEmpty {
            mapView.removeAnnotations(annotationsToRemove)
        }
        
        if !annotationsToAdd.isEmpty {
            mapView.addAnnotations(annotationsToAdd)
        }
    }
    
    private func updateSelectedLocation(on mapView: MKMapView, context: Context) {
        if let selectedLocation = viewModel.selectedLocation {
            if let annotation = mapView.annotations.compactMap({ $0 as? LocationAnnotation })
                .first(where: { $0.location.id == selectedLocation.id }) {
                
                let isSelected = mapView.selectedAnnotations.contains {
                    ($0 as? LocationAnnotation)?.location.id == selectedLocation.id
                }
                
                if !isSelected {
                    mapView.selectAnnotation(annotation, animated: true)
                }
                
                if let annotationView = mapView.view(for: annotation) as? MKMarkerAnnotationView {
                    annotationView.markerTintColor = annotation.color
                }
            }
        } else {
            mapView.selectedAnnotations.forEach { mapView.deselectAnnotation($0, animated: true) }
        }
    }
    
    func makeCoordinator() -> UIMapViewCoordinator {
        UIMapViewCoordinator(self)
    }
    
    private func setupUserTrackingButtonAndCompass(mapView: MKMapView) {
        let trackingButton = MKUserTrackingButton(mapView: mapView)
        trackingButton.layer.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 0.8) : UIColor(white: 1, alpha: 0.8)
        }.cgColor
        trackingButton.layer.cornerRadius = 6
        trackingButton.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(trackingButton)

        let compassButton = MKCompassButton(mapView: mapView)
        compassButton.compassVisibility = .visible
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(compassButton)
        
        let scale = MKScaleView(mapView: mapView)
        scale.legendAlignment = .trailing
        scale.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(scale)

        NSLayoutConstraint.activate([
            trackingButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 10),
            trackingButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
            
            compassButton.topAnchor.constraint(equalTo: trackingButton.bottomAnchor, constant: 10),
            compassButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
            
            scale.trailingAnchor.constraint(equalTo: compassButton.leadingAnchor, constant: -10),
            scale.centerYAnchor.constraint(equalTo: compassButton.centerYAnchor)
        ])

        mapView.showsUserLocation = true
        mapView.showsCompass = false
    }
    
}
