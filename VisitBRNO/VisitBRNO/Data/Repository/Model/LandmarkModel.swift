//
//  LandmarkModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import MapKit

public struct LandmarkModel: MapLocationModel {
    public let id: String
    public let name: String
    public let coordinates: CLLocationCoordinate2D
    
    public init(
        id: String,
        name: String,
        coordinates: CLLocationCoordinate2D
    ) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
    }
}
