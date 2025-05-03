//
//  LocationAnnotation.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import MapKit

class LocationAnnotation: MKPointAnnotation {
    let location: ViewpointModel
    
    init(location: ViewpointModel) {
        self.location = location
        super.init()
        self.title = location.name
        self.coordinate = location.coordinates
    }
}
