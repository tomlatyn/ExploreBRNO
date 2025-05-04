//
//  BaseViewState.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation

enum BaseViewState {
    case loading
    case ok
    case generalError
    case connectionError
    
    static func newViewState(after perform: @MainActor () async throws -> Void) async -> Self {
        do {
            try await perform()
            return .ok
        } catch is ConnectionError {
            return .connectionError
        } catch {
            return .generalError
        }
    }
}
