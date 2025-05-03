//
//  FeatureAssembly.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import Swinject
import SwinjectAutoregistration

final class FeatureAssembly: Assembly {
    func assemble(container: Container) {
        let assemblies: [Assembly] = [
            DashboardFeature()
        ]
        assemblies.forEach { $0.assemble(container: container) }
    }
}
