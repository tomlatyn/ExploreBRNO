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
    
    var model: any MapLocationModel {
        switch self {
        case .viewpoint(let viewpointModel):
            viewpointModel
        case .landmark(let landmarkModel):
            landmarkModel
        }
    }
    
    var id: String {
        switch self {
        case .viewpoint(let viewpointModel):
            viewpointModel.id
        case .landmark(let landmarkModel):
            landmarkModel.id
        }
    }
    
    var pinColor: UIColor {
        switch self {
        case .viewpoint:
                .red
        case .landmark:
                .blue
        }
    }
    
    var type: LocationType {
        switch self {
        case .viewpoint:
                .viewpoint
        case .landmark:
                .landmark
        }
    }
    
    enum LocationType {
        case viewpoint
        case landmark
        
        var name: String {
            switch self {
            case .viewpoint:
                "Viewpoint"
            case .landmark:
                "Landmark"
            }
        }
        
        var collectionName: String {
            switch self {
            case .viewpoint:
                "Viewpoints"
            case .landmark:
                "Landmarks"
            }
        }
    }
}
