//
//  EndpointGetCulturalPlaces.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 08.05.2025.
//

import Foundation
import FTAPIKit

struct EndpointGetCulturalPlaces: ResponseEndpoint {
    typealias Response = CulturalPlacesDTO

    var method = HTTPMethod.get
    var path: String = "ags1/rest/services/OMI/omi_ok_kulturni_instituce/FeatureServer/0/query"
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
