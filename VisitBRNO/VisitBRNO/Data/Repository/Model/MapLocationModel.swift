//
//  MapLocationModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import MapKit

protocol MapLocationModel: Identifiable {
    var id: Int { get }
    var name: String { get }
    var coordinates: CLLocationCoordinate2D { get }
}
