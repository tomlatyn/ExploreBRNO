//
//  DashboardFactory.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI

public protocol DashboardFactory: AnyObject {
    @MainActor var coordinator: DashboardCoordinator { get }
    @MainActor func resolveView() -> AnyView
}
