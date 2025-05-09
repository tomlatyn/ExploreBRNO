//
//  MapLocationType.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 09.05.2025.
//

import Foundation
import SwiftUI

enum MapLocationType: CaseIterable {
    case event
    case culturalPlace
    case viewpoint
    
    var name: String {
        switch self {
        case .viewpoint:
            R.string.localizable.location_type_viewpoint()
        case .event:
            R.string.localizable.location_type_event()
        case .culturalPlace:
            R.string.localizable.location_type_cultural_place()
        }
    }
    
    var collectionName: String {
        switch self {
        case .viewpoint:
            R.string.localizable.location_type_viewpoint_plural()
        case .event:
            R.string.localizable.location_type_event_plural()
        case .culturalPlace:
            R.string.localizable.location_type_cultural_place_plural()
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
