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
            if let stringURL = event.firstImageUrl, let url = URL(string: stringURL) {
                titleImage(url)
            }
            
            let urls = event.images.compactMap { URL(string: $0) }
            if !urls.isEmpty {
                imagesView(urls)
            }
            
            if let description = event.text {
                infoRowView("Description", description)
            }
            
            if let category = event.category {
                infoRowView("Category", category)
            }
            
            if let email = event.organizerEmail {
                infoRowView("Organizer email", email)
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
        }
    }
    
    private func titleImage(_ url: URL) -> some View {
        URLImageView(url: url)
            .cornerRadius(8)
    }
    
    @ViewBuilder
    private func imagesView(_ urls: [URL]) -> some View {
        if urls.count == 1, let url = urls.first {
            URLImageView(url: url)
                .cornerRadius(8)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(urls, id: \.self) { url in
                        URLImageView(url: url)
                            .frame(width: UIScreen.main.bounds.size.width * 0.83)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, -16)
        }
    }
    
}
