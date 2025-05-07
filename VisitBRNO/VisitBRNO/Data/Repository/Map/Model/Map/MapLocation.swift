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
    
    var model: any MapLocationModel {
        switch self {
        case .viewpoint(let viewpointModel):
            viewpointModel
        case .landmark(let landmarkModel):
            landmarkModel
        case .event(let eventModel):
            eventModel
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
        }
    }
    
    enum LocationType: CaseIterable {
        case viewpoint
        case landmark
        case event
        
        var name: String {
            switch self {
            case .viewpoint:
                "Viewpoint"
            case .landmark:
                "Landmark"
            case .event:
                "Event"
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
            }
        }
    }
}
