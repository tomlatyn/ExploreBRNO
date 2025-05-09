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
        VStack(alignment: .leading, spacing: Padding.pt12) {
            let urls = event.images.compactMap { URL(string: $0) }
            if !urls.isEmpty {
                detailImagesView(urls)
            }
            
            if let dateFrom = event.dateFrom,
                let dateTo = event.dateTo,
                let dateValue = getFormattedDateValue(dateFrom: dateFrom, dateTo: dateTo)
            {
                infoRowView(
                    R.string.localizable.map_detail_date(),
                    dateValue,
                    type: .text
                )
            }
            
            if let description = event.text {
                infoRowView(
                    R.string.localizable.map_detail_description(),
                    description,
                    type: .text
                )
            }
            
            if let category = event.category {
                infoRowView(
                    R.string.localizable.map_detail_category(),
                    category,
                    type: .text
                )
            }
            
            if let url = event.url {
                infoRowView(
                    R.string.localizable.map_detail_website(),
                    url,
                    type: .link
                )
            }
            
            if let tickets = event.tickets {
                infoRowView(
                    R.string.localizable.map_detail_tickets_info(),
                    tickets,
                    type: .text
                )
            }
            
            if let tickersUrl = event.ticketsUrl {
                infoRowView(
                    R.string.localizable.map_detail_tickets_website(),
                    tickersUrl,
                    type: .link
                )
            }
            
            if let email = event.organizerEmail {
                infoRowView(
                    R.string.localizable.map_detail_email_organizer(),
                    email,
                    type: .email
                )
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
