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
    let icon: UIImage?
    
    init(location: MapLocation) {
        self.location = location
        self.color = location.type.color
        self.icon = location.type.icon
        super.init()
        self.title = location.model.name
        self.coordinate = location.model.coordinates
    }
}
