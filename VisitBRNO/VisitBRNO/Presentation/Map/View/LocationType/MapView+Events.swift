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
            let urls = event.images.compactMap { URL(string: $0) }
            if !urls.isEmpty {
                detailImagesView(urls)
            }
            
            if let dateFrom = event.dateFrom,
                let dateTo = event.dateTo,
                let dateValue = getFormattedDateValue(dateFrom: dateFrom, dateTo: dateTo)
            {
                infoRowView("Date", dateValue, type: .text)
            }
            
            if let description = event.text {
                infoRowView("Description", description, type: .text)
            }
            
            if let category = event.category {
                infoRowView("Category", category, type: .text)
            }
            
            if let url = event.url {
                infoRowView("Website", url, type: .link)
            }
            
            if let tickets = event.tickets {
                infoRowView("Tickets info", tickets, type: .text)
            }
            
            if let tickersUrl = event.ticketsUrl {
                infoRowView("Tickets website", tickersUrl, type: .link)
            }
            
            if let email = event.organizerEmail {
                infoRowView("Organizer email", email, type: .text)
            }
        }
    }
    
    private func getFormattedDateValue(dateFrom: Int, dateTo: Int) -> String? {
        let fromDate = Date(timeIntervalSince1970: TimeInterval(dateFrom) / 1000)
        let toDate = Date(timeIntervalSince1970: TimeInterval(dateTo) / 1000)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let fromString = dateFormatter.string(from: fromDate)
        let toString = dateFormatter.string(from: toDate)
        
        if fromString == toString {
            return fromString
        } else {
            return "\(fromString) – \(toString)"
        }
    }
    
}
