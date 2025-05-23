//
//  MapCoordinator.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public enum MapPath {
    case pop
}

public protocol MapCoordinator: AnyObject {
    @MainActor func start(_ mapType: MapType)
    @MainActor func navigate(_ path: MapPath)
}
