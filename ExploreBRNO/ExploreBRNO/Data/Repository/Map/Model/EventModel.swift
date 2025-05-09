//
//  EventModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import MapKit

public struct EventModel: MapLocationModel {
    public let id: String
    public let name: String
    public let coordinates: CLLocationCoordinate2D
    public let text: String?
    public let tickets: String?
    public let images: [String]
    public let url: String?
    public let category: String?
    public let organizerEmail: String?
    public let ticketsUrl: String?
    public let dateFrom: Int?
    public let dateTo: Int?
}
