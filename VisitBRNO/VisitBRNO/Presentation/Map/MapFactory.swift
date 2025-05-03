//
//  MapFactory.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI

public protocol MapFactory: AnyObject {
    @MainActor var coordinator: MapCoordinator { get }
    @MainActor func resolveView() -> AnyView
}
