//
//  DashboardCoordinator.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public enum DashboardPath {

}

public protocol DashboardCoordinator: AnyObject {
    @MainActor func start()
    @MainActor func navigate(_ path: DashboardPath)
}
