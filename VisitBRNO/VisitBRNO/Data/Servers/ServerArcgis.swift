//
//  ServerArcgis.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import FTAPIKit

/// Used for:
/// - Events
struct ServerArcgis: URLServer {

    var baseUri: URL {
        URL(string: "https://services6.arcgis.com/fUWVlHWZNxUvTUh8/arcgis/rest/services/")!
    }

    let decoding: Decoding = JSONDecoding { decoder in
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}
