//
//  ViewpointModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import MapKit

public struct ViewpointModel: Identifiable {
    public let id: Int
    public let name: String
    public let altitude: Double
    public let coordinates: CLLocationCoordinate2D
    
    public init(
        id: Int,
        name: String,
        altitude: Double,
        coordinates: CLLocationCoordinate2D
    ) {
        self.id = id
        self.name = name
        self.altitude = altitude
        self.coordinates = coordinates
    }
}
