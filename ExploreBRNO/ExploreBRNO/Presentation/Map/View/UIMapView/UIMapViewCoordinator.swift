//
//  UIMapViewCoordinator.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import UIKit
import SwiftUI
import MapKit

class UIMapViewCoordinator: NSObject, MKMapViewDelegate {
    var parent: UIMapView
    
    init(_ parent: UIMapView) {
        self.parent = parent
        super.init()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        if let cluster = annotation as? MKClusterAnnotation {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? MKMarkerAnnotationView
                ?? MKMarkerAnnotationView(annotation: cluster, reuseIdentifier: "cluster")
                
            annotationView.markerTintColor = R.color.blue()!
            annotationView.glyphText = String(cluster.memberAnnotations.count)
            return annotationView
        }
        
        if let locationAnnotation = annotation as? LocationAnnotation {
            let identifier = "LocationPin"
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
                ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView.annotation = annotation
            annotationView.canShowCallout = false
            
            annotationView.glyphImage = locationAnnotation.icon
            
            if let selectedLocation = parent.viewModel.selectedLocation,
               locationAnnotation.location.id == selectedLocation.id {
                annotationView.markerTintColor = locationAnnotation.color.withAlphaComponent(0.8)
            } else {
                annotationView.markerTintColor = locationAnnotation.color
            }
            
            annotationView.clusteringIdentifier = "locations"
            
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let cluster = view.annotation as? MKClusterAnnotation {
            let identicalAnnotations = cluster.memberAnnotations.compactMap { $0 as? LocationAnnotation }
                .filter {
                    let lat1 = Double(round(100000 * $0.coordinate.latitude) / 100000)
                    let lon1 = Double(round(100000 * $0.coordinate.longitude) / 100000)
                    let lat2 = Double(round(100000 * cluster.coordinate.latitude) / 100000)
                    let lon2 = Double(round(100000 * cluster.coordinate.longitude) / 100000)
                    return lat1 == lat2 && lon1 == lon2
                }
            
            if identicalAnnotations.count > 1 {
                parent.showSelectionList(identicalAnnotations)
                let region = MKCoordinateRegion(
                    center: cluster.coordinate,
                    span: mapView.region.span
                )
                mapView.setRegion(region, animated: true)
                return
            }
            
            mapView.deselectAnnotation(cluster, animated: false)
            
            let region = MKCoordinateRegion(
                center: cluster.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: mapView.region.span.latitudeDelta * 0.5,
                    longitudeDelta: mapView.region.span.longitudeDelta * 0.5
                )
            )
            mapView.setRegion(region, animated: true)
        } else if let locationAnnotation = view.annotation as? LocationAnnotation {
            DispatchQueue.main.async { [weak self] in
                self?.parent.viewModel.selectLocation(locationAnnotation.location)
            }
            
            if let markerView = view as? MKMarkerAnnotationView {
                markerView.markerTintColor = locationAnnotation.color.withAlphaComponent(0.8)
            }
            
            let latitudeOffset = mapView.region.span.latitudeDelta * 0.11
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: locationAnnotation.coordinate.latitude - latitudeOffset,
                    longitude: locationAnnotation.coordinate.longitude
                ),
                span: mapView.region.span
            )
            mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let locationAnnotation = view.annotation as? LocationAnnotation,
           let markerView = view as? MKMarkerAnnotationView {
            
            markerView.markerTintColor = locationAnnotation.color
            if let selectedLocation = parent.viewModel.selectedLocation,
               locationAnnotation.location.id == selectedLocation.id,
               mapView.selectedAnnotations.isEmpty {
                DispatchQueue.main.async { [weak self] in
                    self?.parent.viewModel.selectLocation(nil)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        views.forEach { $0.alpha = 0 }
        UIView.animate(withDuration: 0.3) {
            views.forEach { $0.alpha = 1 }
        }
    }
}
