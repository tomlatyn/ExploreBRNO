//
//  MapView+Viewpoints.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 06.05.2025.
//

import Foundation
import SwiftUI
import MapKit

extension MapView {
    
    func viewpointDetailView(_ viewpoint: ViewpointModel) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            infoRowView(
                R.string.localizable.map_detail_altitude(),
                "\(NSString(format: "%.01f", viewpoint.altitude)) \(R.string.localizable.map_detail_meters())",
                type: .text
            )
        }
    }
    
}
