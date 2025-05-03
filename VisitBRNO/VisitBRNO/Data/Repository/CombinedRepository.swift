//
//  CombinedRepository.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public protocol CombinedRepository: AnyObject {
    func getViewpoints() async throws -> ViewpointsDTO
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
    
    public func getViewpoints() async throws -> ViewpointsDTO {
        try await restClient.call { [serverGis] in
            try await serverGis.call(response: EndpointGetViewpoints())
        }
    }
    
}
