//
//  LandmarkModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import MapKit

public struct LandmarkModel: MapLocationModel {
    public let id: Int
    public let name: String
    public let coordinates: CLLocationCoordinate2D
    
    public init(
        id: Int,
        name: String,
        coordinates: CLLocationCoordinate2D
    ) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
    }
}
