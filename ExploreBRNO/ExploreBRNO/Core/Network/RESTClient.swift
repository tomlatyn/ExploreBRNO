//
//  RESTClient.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import FTAPIKit
import OSLog

public protocol RESTClient: AnyObject, Sendable {
    func call<T>(
        perform: @escaping () async throws -> T,
        tryHandleError: @escaping (Error, StatusCode, @escaping (Error) async throws -> T) async throws -> T
    ) async throws -> T
}

public extension RESTClient {
    func call<T>(
        perform: @escaping () async throws -> T
    ) async throws -> T {
        try await call(
            perform: perform,
            tryHandleError: { error, _, _ in throw error }
        )
    }
}

public final class RESTClientImpl: RESTClient {

    private let logger = Logger()

    public init() {
        
    }

    public func call<T>(
        perform: @escaping () async throws -> T,
        tryHandleError: @escaping (Error, StatusCode, @escaping (Error) async throws -> T) async throws -> T
    ) async throws -> T {
        try await callBody(perform: perform, tryHandleError: tryHandleError)
    }

    public func callBody<T>(
        perform: @escaping  () async throws -> T,
        tryHandleError: @escaping (Error, StatusCode, @escaping (Error) async throws -> T) async throws -> T
    ) async throws -> T {
        try await withExponentialBackoffRetry { [weak self] retry in
            do {
                return try await perform()
            } catch let error as APIErrorStandard {
                self?.logger.error("\(error)")
                switch error {
                case let .connection(error):
                    return try await retry(ConnectionError.timeout(String(describing: error)))
                case .decoding:
                    throw MappingError.decoding(String(describing: error))
                case .encoding:
                    throw MappingError.encoding(String(describing: error))
                case let .server(statusCode, _, _):
                    return try await tryHandleError(error, statusCode, retry)
                default:
                    throw GeneralError.unknown(String(describing: error))
                }
            }
        }
    }
}
