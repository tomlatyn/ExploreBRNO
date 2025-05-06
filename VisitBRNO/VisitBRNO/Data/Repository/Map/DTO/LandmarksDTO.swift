//
//  LandmarksDTO.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import MapKit

struct LandmarksDTO: Codable {
    let features: [Feature]
    
    // MARK: - Feature
    
    struct Feature: Codable {
        let attributes: Attributes
        let geometry: Geometry
        
        // MARK: - Attributes
        
        struct Attributes: Codable {
            let objectid: Int
            let nazev: String
            
            enum CodingKeys: String, CodingKey {
                case objectid = "objectid"
                case nazev = "nazev"
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

extension LandmarksDTO.Feature {
    func mapToModel() -> LandmarkModel {
        LandmarkModel(
            id: "landmark_\(attributes.objectid)",
            name: attributes.nazev,
            coordinates: CLLocationCoordinate2D(
                latitude: geometry.y,
                longitude: geometry.x
            )
        )
    }
}
