//
//  MapViewModel+LocationDelegate.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 05.05.2025.
//

import Foundation
import MapKit

extension MapViewModel: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location.coordinate
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
}
