//
//  LocationAnnotation.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import MapKit

class LocationAnnotation: MKPointAnnotation {
    let location: MapLocation
    let color: UIColor
    
    init(location: MapLocation) {
        self.location = location
        self.color = location.pinColor
        super.init()
        self.title = location.model.name
        self.coordinate = location.model.coordinates
    }
}
