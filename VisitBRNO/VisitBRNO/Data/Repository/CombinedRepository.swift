//
//  CombinedRepository.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public protocol CombinedRepository: AnyObject {
    func getViewpoints() async throws -> [ViewpointModel]
    func getLandmarks() async throws -> [LandmarkModel]
}

public final class CombinedRepositoryImpl: CombinedRepository {
    
    private let restClient: RESTClient
    private let serverGis: ServerGis
    
    init(
        restClient: RESTClient,
        serverGis: ServerGis
    ) {
        self.restClient = restClient
        self.serverGis = serverGis
    }
    
    public func getViewpoints() async throws -> [ViewpointModel] {
        try await restClient.call { [serverGis] in
            try await serverGis.call(response: EndpointGetViewpoints())
                .features
                .map { $0.mapToModel() }
        }
    }
    
    public func getLandmarks() async throws -> [LandmarkModel] {
        try await restClient.call { [serverGis] in
            try await serverGis.call(response: EndpointGetLandmarks())
                .features
                .map { $0.mapToModel() }
        }
    }
    
}
