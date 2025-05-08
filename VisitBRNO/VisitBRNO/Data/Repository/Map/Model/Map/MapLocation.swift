//
//  MapLocation.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import SwiftUI

enum MapLocation {
    case viewpoint(ViewpointModel)
    case event(EventModel)
    case culturalPlace(CulturalPlaceModel)
    
    var model: any MapLocationModel {
        switch self {
        case .viewpoint(let viewpointModel):
            viewpointModel
        case .event(let eventModel):
            eventModel
        case .culturalPlace(let culturalPlaceModel):
            culturalPlaceModel
        }
    }
    
    var id: String {
        switch self {
        case .viewpoint(let viewpointModel):
            viewpointModel.id
        case .event(let eventModel):
            eventModel.id
        case .culturalPlace(let culturalPlaceModel):
            culturalPlaceModel.id
        }
    }
    
    var type: LocationType {
        switch self {
        case .viewpoint:
                .viewpoint
        case .event:
                .event
        case .culturalPlace:
                .culturalPlace
        }
    }
    
    enum LocationType: CaseIterable {
        case event
        case culturalPlace
        case viewpoint
        
        var name: String {
            switch self {
            case .viewpoint:
                "Viewpoint"
            case .event:
                "Event"
            case .culturalPlace:
                "Cultural Place"
            }
        }
        
        var collectionName: String {
            switch self {
            case .viewpoint:
                "Viewpoints"
            case .event:
                "Events"
            case .culturalPlace:
                "Cultural Places"
            }
        }
        
        var color: UIColor {
            switch self {
            case .viewpoint:
                    .red
            case .event:
                    .orange
            case .culturalPlace:
                    .blue
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .viewpoint:
                UIImage(systemName: "binoculars")
            case .event:
                UIImage(systemName: "calendar.badge.checkmark")
            case .culturalPlace:
                UIImage(systemName: "theatermasks")
            }
        }
    }
}
