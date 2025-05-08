//
//  CombinedRepository.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public protocol MapRepository: AnyObject {
    func getViewpoints() async throws -> [ViewpointModel]
    func getEvents() async throws -> [EventModel]
    func getCulturalPlaces() async throws -> [CulturalPlaceModel]
    
    func updateLocationBookmark(id: String, bookmarked: Bool)
    func getBookmarkedLocations() -> [String]
}

public final class MapRepositoryImpl: MapRepository {
    
    // MARK: - Instance properties
    
    private let userDefaults = UserDefaults.standard
    private let restClient: RESTClient
    private let serverGis: ServerGis
    private let serverArcgis: ServerArcgis
    
    // MARK: - Lifecycle
    
    init(
        restClient: RESTClient,
        serverGis: ServerGis,
        serverArcgis: ServerArcgis
    ) {
        self.restClient = restClient
        self.serverGis = serverGis
        self.serverArcgis = serverArcgis
    }
    
    // MARK: - Implementation
    
    public func getViewpoints() async throws -> [ViewpointModel] {
        try await restClient.call { [serverGis] in
            try await serverGis.call(response: EndpointGetViewpoints())
                .features
                .map { $0.mapToModel() }
        }
    }
    
    public func getEvents() async throws -> [EventModel] {
        try await restClient.call { [serverArcgis] in
            try await serverArcgis.call(response: EndpointGetEvents())
                .features
                .map { $0.mapToModel() }
        }
    }
    
    public func getCulturalPlaces() async throws -> [CulturalPlaceModel] {
        try await restClient.call { [serverGis] in
            try await serverGis.call(response: EndpointGetCulturalPlaces())
                .features
                .compactMap { $0.mapToModel() }
        }
    }
    
    public func updateLocationBookmark(id: String, bookmarked: Bool) {
        var bookmarks = getBookmarkedLocations()
        if bookmarked {
            bookmarks.append(id)
        } else {
            bookmarks.removeAll(where: { $0 == id })
        }
        userDefaults.set(bookmarks, forKey: UserDefaultsKeys.bookmarkedLocations.rawValue)
    }
    
    public func getBookmarkedLocations() -> [String] {
        userDefaults.array(forKey: UserDefaultsKeys.bookmarkedLocations.rawValue) as? [String] ?? []
    }
    
}
