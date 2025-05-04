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
    
    var id: Int {
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
}
