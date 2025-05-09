//
//  CulturalPlacesDTO.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 08.05.2025.
//

import Foundation
import MapKit

public struct CulturalPlacesDTO: Codable {
    let features: [Feature]
    
    // MARK: - Feature
    
    struct Feature: Codable {
        let attributes: Attributes
        let geometry: Geometry?
        
        // MARK: - Attributes
        
        struct Attributes: Codable {
            let objectid: Int
            let nazev: String
            let druh: String?
            let poznamka: String?
            let web: String?
            let program: String?
            let email, telefon: String?
            let nazevEn, poznamkaEn: String?
            let otevreneOd, otevreneDo: Int?
            let obrId1, obrId2, obrId3: String?

            enum CodingKeys: String, CodingKey {
                case objectid
                case nazev, druh, poznamka, web, program
                case email, telefon
                case nazevEn = "nazev_en"
                case poznamkaEn = "poznamka_en"
                case otevreneOd = "otevrene_od"
                case otevreneDo = "otevrene_do"
                case obrId1 = "obr_id1"
                case obrId2 = "obr_id2"
                case obrId3 = "obr_id3"
            }
        }

        // MARK: - Geometry
        
        struct Geometry: Codable {
            let x, y: Double
        }
    }
}

// MARK: - Mapping

extension CulturalPlacesDTO.Feature {
    func mapToModel() -> CulturalPlaceModel? {
        guard let geometry = geometry else { return nil }
        return CulturalPlaceModel(
            id: "culture_\(attributes.objectid)",
            name: attributes.nazevEn ?? attributes.nazev,
            coordinates: CLLocationCoordinate2D(
                latitude: geometry.y,
                longitude: geometry.x
            ),
            note: attributes.poznamkaEn ?? attributes.poznamka,
            images: [
                attributes.obrId1,
                attributes.obrId2,
                attributes.obrId3
            ]
            .compactMap { $0 },
            web: attributes.web,
            category: attributes.druh,
            email: attributes.email,
            phones: attributes.telefon?
                .components(separatedBy: ",")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } ?? [],
            openFrom: attributes.otevreneOd,
            openTo: attributes.otevreneDo
        )
    }
}
