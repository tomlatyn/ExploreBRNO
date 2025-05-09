//
//  EndpointGetEvents.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import FTAPIKit

struct EndpointGetEvents: ResponseEndpoint {
    typealias Response = EventsDTO

    var method = HTTPMethod.get
    var path: String = "fUWVlHWZNxUvTUh8/arcgis/rest/services/Events/FeatureServer/0/query"
    var query: URLQuery

    init() {
        query = [
            "where": "1=1",
            "outFields": "*",
            "outSR": "4326",
            "f": "json"
        ]
    }
    
}
