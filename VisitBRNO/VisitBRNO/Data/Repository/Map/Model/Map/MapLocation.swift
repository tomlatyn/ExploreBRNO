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
    case landmark(LandmarkModel)
    case event(EventModel)
    case culturalPlace(CulturalPlaceModel)
    
    var model: any MapLocationModel {
        switch self {
        case .viewpoint(let viewpointModel):
            viewpointModel
        case .landmark(let landmarkModel):
            landmarkModel
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
        case .landmark(let landmarkModel):
            landmarkModel.id
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
        case .landmark:
                .landmark
        case .event:
                .event
        case .culturalPlace:
                .culturalPlace
        }
    }
    
    enum LocationType: CaseIterable {
        case viewpoint
        case landmark
        case event
        case culturalPlace
        
        var name: String {
            switch self {
            case .viewpoint:
                "Viewpoint"
            case .landmark:
                "Landmark"
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
            case .landmark:
                "Landmarks"
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
            case .landmark:
                    .blue
            case .event:
                    .orange
            case .culturalPlace:
                    .yellow
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .viewpoint:
                UIImage(systemName: "binoculars")
            case .landmark:
                UIImage(systemName: "building.columns")
            case .event:
                UIImage(systemName: "calendar.badge.checkmark")
            case .culturalPlace:
                UIImage(systemName: "theatermasks")
            }
        }
    }
}
