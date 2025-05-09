//
//  MapType.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation

public enum MapType {
    case all
    case viewpoints
    case events
    case culturalPlaces
    
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
}
