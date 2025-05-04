//
//  MapView+Events.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 04.05.2025.
//

import Foundation
import SwiftUI
import MapKit

extension MapView {
    
    func eventDetailView(_ event: EventModel) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(event.name)
            
            Text(event.category ?? "no category")
        }
    }
    
}
