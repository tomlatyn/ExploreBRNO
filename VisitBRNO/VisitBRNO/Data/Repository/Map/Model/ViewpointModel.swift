//
//  ViewpointModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import MapKit

public struct ViewpointModel: MapLocationModel {
    public let id: String
    public let name: String
    public let altitude: Float
    public let coordinates: CLLocationCoordinate2D
}
