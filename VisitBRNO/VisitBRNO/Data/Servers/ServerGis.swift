//
//  ServerGis.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import FTAPIKit

/// Used for:
/// - Cultural Places
/// - Viewpoints
struct ServerGis: URLServer {

    var baseUri: URL {
        URL(string: "https://gis.brno.cz/")!
    }

    let decoding: Decoding = JSONDecoding { decoder in
        decoder.keyDecodingStrategy = .useDefaultKeys
    }
}
