//
//  EndpointGetViewpoints.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import FTAPIKit

struct EndpointGetViewpoints: ResponseEndpoint {
    typealias Response = ViewpointsDTO

    var method = HTTPMethod.get
    var path: String = "ags1/rest/services/ODAE/ODAE_vyhlidkove_body/FeatureServer/0/query"
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
