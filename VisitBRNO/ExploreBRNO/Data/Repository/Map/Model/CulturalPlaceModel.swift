//
//  CulturalPlaceModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 08.05.2025.
//

import Foundation
import MapKit

public struct CulturalPlaceModel: MapLocationModel {
    public let id: String
    public let name: String
    public let coordinates: CLLocationCoordinate2D
    public let note: String?
    public let images: [String]
    public let web: String?
    public let category: String?
    public let email: String?
    public let phones: [String]
    public let openFrom: Int?
    public let openTo: Int?
}
