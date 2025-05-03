//
//  DashboardViewModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public final class DashboardViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let combinedRepository: CombinedRepository
    
    // MARK: - Published properties
    
    // MARK: - Lifecycle
    
    public nonisolated init(
        combinedRepository: CombinedRepository
    ) {
        self.combinedRepository = combinedRepository
    }
    
    // MARK: -
    
    func loadData() {
        Task {
            try? await print(combinedRepository.getViewpoints())
        }
    }
    
}
