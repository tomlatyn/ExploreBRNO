//
//  ViewpointDTO.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public struct ViewpointsDTO: Codable {
    let objectIdFieldName: String
    let globalIdFieldName: String
    let geometryType: String
    let spatialReference: SpatialReference
    let fields: [Field]
    let features: [Feature]
    
    enum CodingKeys: String, CodingKey {
        case objectIdFieldName = "objectIdFieldName"
        case globalIdFieldName = "globalIdFieldName"
        case geometryType = "geometryType"
        case spatialReference = "spatialReference"
        case fields = "fields"
        case features = "features"
    }
}

// MARK: - Field
struct Field: Codable {
    let name: String
    let alias: String
    let type: String
    let length: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case alias = "alias"
        case type = "type"
        case length = "length"
    }
}

// MARK: - Feature
struct Feature: Codable {
    let attributes: Attributes
    let geometry: Geometry
    
    enum CodingKeys: String, CodingKey {
        case attributes = "attributes"
        case geometry = "geometry"
    }
}

// MARK: - Attributes
struct Attributes: Codable {
    let objectid: Int
    let fid1: Double?
    let layer: String
    let nazev: String
    let vyskaPozo: Double?
    let kolikKdL: Int?
    let nadmorskaVyska: Double
    
    enum CodingKeys: String, CodingKey {
        case objectid = "objectid"
        case fid1 = "fid_1"
        case layer = "layer"
        case nazev = "nazev"
        case vyskaPozo = "vyska_pozo"
        case kolikKdL = "kolik_kd_l"
        case nadmorskaVyska = "nadmorska_"
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let x: Double
    let y: Double
    
    enum CodingKeys: String, CodingKey {
        case x = "x"
        case y = "y"
    }
}

// MARK: - SpatialReference
struct SpatialReference: Codable {
    let wkid: Int
    let latestWkid: Int
    
    enum CodingKeys: String, CodingKey {
        case wkid = "wkid"
        case latestWkid = "latestWkid"
    }
}
