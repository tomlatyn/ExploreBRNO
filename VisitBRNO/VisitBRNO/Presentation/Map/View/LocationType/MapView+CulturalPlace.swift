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
                infoRowView("Open Hours", dateValue, type: .text)
            }
            
            if let note = place.note {
                infoRowView("Note", note, type: .text)
            }
            
            if let category = place.category {
                infoRowView("Category", category, type: .text)
            }
            
            if let url = place.web {
                infoRowView("Website", url, type: .link)
            }
            
            if let email = place.email {
                infoRowView("Email", email, type: .email)
            }
            
            if !place.phones.isEmpty {
                ForEach(Array(place.phones.enumerated()), id: \.element) { index, phone in
                    infoRowView(place.phones.count > 1 ? "Phone \(index + 1)" : "Phone", phone, type: .phone)
                }
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
