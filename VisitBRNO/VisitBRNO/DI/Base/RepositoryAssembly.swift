//
//  RepositoryAssembly.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Swinject
import SwinjectAutoregistration

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(CombinedRepository.self, initializer: CombinedRepositoryImpl.init).inObjectScope(.container)
    }
}
