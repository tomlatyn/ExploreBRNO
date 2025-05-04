//
//  EventsDTO.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import MapKit

public struct EventsDTO: Codable {
    let features: [Feature]
    
    // MARK: - Feature
    
    struct Feature: Codable {
        let attributes: Attributes
        let geometry: Geometry
        
        // MARK: - Attributes
        
        struct Attributes: Codable {
            let id: Int
            let name: String
            let text, tickets: String?
            let ticketsInfo: String?
            let images: String?
            let url: String?
            let categories: String?
            let parentFestivals: String?
            let organizerEmail: String?
            let ticketsURL: String?
            let nameEn, textEn: String?
            let urlEn: String?
            let ticketsURLEn: String?
            let latitude, longitude: Double
            let dateFrom, dateTo: Int?
            let firstImage: String?

            enum CodingKeys: String, CodingKey {
                case id = "ID"
                case name, text, tickets
                case ticketsInfo = "tickets_info"
                case images, url, categories
                case parentFestivals = "parent_festivals"
                case organizerEmail = "organizer_email"
                case ticketsURL = "tickets_url"
                case nameEn = "name_en"
                case textEn = "text_en"
                case urlEn = "url_en"
                case ticketsURLEn = "tickets_url_en"
                case latitude, longitude
                case dateFrom = "date_from"
                case dateTo = "date_to"
                case firstImage = "first_image"
            }
        }

        // MARK: - Geometry
        
        struct Geometry: Codable {
            let x, y: Double
        }
    }
}

// MARK: - Mapping

extension EventsDTO.Feature {
    func mapToModel() -> EventModel {
        EventModel(
            id: "event_\(attributes.id)",
            name: attributes.nameEn ?? attributes.name,
            coordinates: CLLocationCoordinate2D(
                latitude: geometry.y,
                longitude: geometry.x
            ),
            text: attributes.text ?? attributes.textEn,
            tickets: attributes.tickets,
            images: attributes.images?.components(separatedBy: ",") ?? [],
            url: attributes.urlEn ?? attributes.url,
            category: attributes.categories,
            organizerEmail: attributes.organizerEmail,
            ticketsUrl: attributes.ticketsURLEn ?? attributes.ticketsURL,
            dateFrom: attributes.dateFrom,
            dateTo: attributes.dateTo,
            firstImageUrl: attributes.firstImage
        )
    }
}
