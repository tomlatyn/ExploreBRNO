//
//  ViewpointDTO.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import MapKit

public struct ViewpointsDTO: Codable {
    let features: [Feature]
    
    // MARK: - Feature
    
    struct Feature: Codable {
        let attributes: Attributes
        let geometry: Geometry
        
        // MARK: - Attributes
        
        struct Attributes: Codable {
            let objectid: Int
            let nazev: String
            let nadmorskaVyska: Double
            
            enum CodingKeys: String, CodingKey {
                case objectid = "objectid"
                case nazev = "nazev"
                case nadmorskaVyska = "nadmorska_"
            }
        }
        
        // MARK: - Geometry
        
        struct Geometry: Codable {
            let x: Double
            let y: Double
        }
    }
}

// MARK: - Mapping

extension ViewpointsDTO.Feature {
    func mapToModel() -> ViewpointModel {
        ViewpointModel(
            id: "viewpoint_\(attributes.objectid)",
            name: attributes.nazev,
            altitude: attributes.nadmorskaVyska,
            coordinates: CLLocationCoordinate2D(
                latitude: geometry.y,
                longitude: geometry.x
            )
        )
    }
}
