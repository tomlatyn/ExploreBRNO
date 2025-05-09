//
//  MapType.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import SwiftUI

public enum MapType: CaseIterable {
    case all
    case events
    case culturalPlaces
    case viewpoints
    
    var navigationTitle: String {
        switch self {
        case .all:
            R.string.localizable.map_title_all()
        case .viewpoints:
            R.string.localizable.map_title_viewpoints()
        case .events:
            R.string.localizable.map_title_events()
        case .culturalPlaces:
            R.string.localizable.map_title_cultural_places()
        }
    }
    
    var loadingText: String {
        switch self {
        case .all:
            R.string.localizable.map_loading_all()
        case .viewpoints:
            R.string.localizable.map_loading_viewpoints()
        case .events:
            R.string.localizable.map_loading_events()
        case .culturalPlaces:
            R.string.localizable.map_loading_cultural_places()
        }
    }
    
    var navigationColor: Color {
        switch self {
        case .all:
            Color(R.color.primary()!)
        case .viewpoints:
            Color(MapLocationType.viewpoint.color)
        case .events:
            Color(MapLocationType.event.color)
        case .culturalPlaces:
            Color(MapLocationType.culturalPlace.color)
        }
    }
    
    var icon: Image {
        switch self {
        case .all:
            Image(systemName: "map")
        case .viewpoints:
            Image(uiImage: MapLocationType.viewpoint.icon)
        case .events:
            Image(uiImage: MapLocationType.event.icon)
        case .culturalPlaces:
            Image(uiImage: MapLocationType.culturalPlace.icon)
        }
    }
}
