//
//  Constants.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import MapKit

struct Constants {
    static let defaultMapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.19492956343889, longitude: 16.608378039964823),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    static let emailRegex = try? NSRegularExpression(
        pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        options: .caseInsensitive
    )
}
