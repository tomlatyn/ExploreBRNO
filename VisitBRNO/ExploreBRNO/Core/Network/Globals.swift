//
//  Globals.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public func withRetry<T>(
    maxAttempts: UInt = 3,
    _ perform: @escaping (@escaping (Error) async throws -> T) async throws -> T
) async throws -> T {
    func retry(error: Error, attempt: UInt) async throws -> T {
        guard attempt < maxAttempts else { throw error }
        return try await perform { try await retry(error: $0, attempt: attempt + 1) }
    }
    return try await perform { try await retry(error: $0, attempt: 0) }
}

public func exponentialBackoff(
    interval: Int,
    attempt: Int,
    randomizationRange: ClosedRange<TimeInterval> = 0.0...0.5
) -> TimeInterval {
    let exponential = TimeInterval(truncating: pow(2, attempt) as NSNumber)
    let randomization = TimeInterval.random(in: randomizationRange)
    return TimeInterval(interval) * (exponential + randomization)
}

public func withExponentialBackoffRetry<T>(
    maxAttempts: Int = 3,
    _ perform: @escaping (@escaping (Error) async throws -> T) async throws -> T
) async throws -> T {
    func retry(error: Error, attempt: Int) async throws -> T {
        guard attempt < maxAttempts else { throw error }
        let backoff = exponentialBackoff(interval: 1_000_000_000, attempt: attempt)
        try await Task.sleep(nanoseconds: UInt64(backoff))
        return try await perform { try await retry(error: $0, attempt: attempt + 1) }
    }

    return try await perform { try await retry(error: $0, attempt: 0) }
}
