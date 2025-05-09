//
//  AppDI.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Swinject

final class AppDI {
    let container: Container
    private let assembler: Assembler

    init() {
        container = Container()
        assembler = Assembler(
            [
                CoreAssembly(),
                FeatureAssembly(),
                RepositoryAssembly()
            ],
            container: container
        )
    }
}
