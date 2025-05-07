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
                imagesView(urls)
            }
            
            if let dateFrom = event.dateFrom,
                let dateTo = event.dateTo,
                let dateValue = getFormattedDateValue(dateFrom: dateFrom, dateTo: dateTo)
            {
                infoRowView("Date", dateValue)
            }
            
            if let description = event.text {
                infoRowView("Description", description)
            }
            
            if let category = event.category {
                infoRowView("Category", category)
            }
            
            if let url = event.url {
                infoRowView("Website", url)
            }
            
            if let tickets = event.tickets {
                infoRowView("Tickets info", tickets)
            }
            
            if let tickersUrl = event.ticketsUrl {
                infoRowView("Tickets website", tickersUrl)
            }
            
            if let email = event.organizerEmail {
                infoRowView("Organizer email", email)
            }
        }
        .onAppear {
            print(event)
        }
    }
    
    @ViewBuilder
    private func imagesView(_ urls: [URL]) -> some View {
        if urls.count == 1, let url = urls.first {
            URLImageView(url: url)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(urls, id: \.self) { url in
                        URLImageView(url: url)
                            .frame(width: UIScreen.main.bounds.size.width * 0.83)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, -16)
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
