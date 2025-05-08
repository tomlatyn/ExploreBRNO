//
//  MapView+CulturalPlace.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 08.05.2025.
//

import Foundation
import SwiftUI
import MapKit

extension MapView {
    
    func culturalPlaceDetailView(_ place: CulturalPlaceModel) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            let urls = place.images.compactMap { URL(string: $0) }
            if !urls.isEmpty {
                detailImagesView(urls)
            }
            
            if let openFrom = place.openFrom,
               let openTo = place.openTo,
               let dateValue = getFormattedTimeValue(timeFrom: openFrom, timeTo: openTo)
            {
                infoRowView("Open Hours", dateValue)
            }
            
            if let note = place.note {
                infoRowView("Note", note)
            }
            
            if let category = place.category {
                infoRowView("Category", category)
            }
            
            if let url = place.web {
                infoRowView("Website", url)
            }
            
            if let email = place.email {
                infoRowView("Email", email)
            }
            
            if let phone = place.phone {
                infoRowView("Phone", phone)
            }
        }
    }
    
    private func getFormattedTimeValue(timeFrom: Int, timeTo: Int) -> String? {
        let fromDate = Date(timeIntervalSince1970: TimeInterval(timeFrom) / 1000)
        let toDate = Date(timeIntervalSince1970: TimeInterval(timeTo) / 1000)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let fromString = dateFormatter.string(from: fromDate)
        let toString = dateFormatter.string(from: toDate)
        
        if fromString == toString {
            return fromString
        } else {
            return "\(fromString) – \(toString)"
        }
    }
    
}
