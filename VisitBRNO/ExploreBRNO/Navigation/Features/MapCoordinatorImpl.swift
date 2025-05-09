//
//  MapCoordinatorImpl.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI

final class MapCoordinatorImpl: MapCoordinator {
    
    // MARK: - Properties
    
    private let appCoordinator: AppCoordinator
    private let factory: MapFactory
    
    // MARK: - Lifecycle
    
    nonisolated init(
        appCoordinator: AppCoordinator,
        factory: MapFactory
    ) {
        self.appCoordinator = appCoordinator
        self.factory = factory
    }
    
    // MARK: - Navigation
    
    func start(_ mapType: MapType) {
        let vc = UIHostingController(rootView: factory.resolveView(mapType))
        vc.title = mapType.navigationTitle
        appCoordinator.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigate(_ path: MapPath) {
        switch path {
        case .pop:
            appCoordinator.pop()
        }
    }
}
