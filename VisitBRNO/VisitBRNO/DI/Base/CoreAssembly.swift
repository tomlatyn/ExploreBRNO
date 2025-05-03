//
//  CoreAssembly.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import UIKit
import Swinject
import SwinjectAutoregistration

final class CoreAssembly: Assembly {
    func assemble(container: Container) {
        let navigationController = UINavigationController()
        container.register(AppCoordinator.self) { r in
            AppCoordinatorImpl(
                navigationController: navigationController,
                dashboardFactory: r.resolve(DashboardFactory.self)!
            )
        }.inObjectScope(.container)
        
        container.autoregister(ServerGis.self, initializer: ServerGis.init)
        container.autoregister(ServerArcgis.self, initializer: ServerArcgis.init)
        
        container.autoregister(RESTClient.self, initializer: RESTClientImpl.init)
    }
}
