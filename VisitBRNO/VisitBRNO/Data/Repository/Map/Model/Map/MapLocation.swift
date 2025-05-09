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
    
    var type: MapLocationType {
        switch self {
        case .viewpoint:
                .viewpoint
        case .event:
                .event
        case .culturalPlace:
                .culturalPlace
        }
    }
    
}
