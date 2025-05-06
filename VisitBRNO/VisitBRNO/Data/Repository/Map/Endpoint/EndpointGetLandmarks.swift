//
//  EndpointGetLandmarks.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import FTAPIKit

struct EndpointGetLandmarks: ResponseEndpoint {
    typealias Response = LandmarksDTO

    var method = HTTPMethod.get
    var path: String = "ags1/rest/services/ODAE/ODAE_kulturni_dominanty/FeatureServer/0/query"
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
