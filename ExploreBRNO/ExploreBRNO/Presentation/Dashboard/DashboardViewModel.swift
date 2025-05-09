//
//  DashboardViewModel.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public final class DashboardViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let combinedRepository: MapRepository
    
    // MARK: - Published properties
    
    @Published var isInfoPresented = false
    
    // MARK: - Lifecycle
    
    public nonisolated init(
        combinedRepository: MapRepository
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
