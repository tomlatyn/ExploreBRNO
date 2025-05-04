//
//  MapConstants.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import MapKit

struct MapConstants {
    static let defaultMapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.19492956343889, longitude: 16.608378039964823),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
}
