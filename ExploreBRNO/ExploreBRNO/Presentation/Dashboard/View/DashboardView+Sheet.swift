//
//  DashboardView+Sheet.swift
//  ExploreBRNO
//
//  Created by Tomáš Latýn on 09.05.2025.
//

import Foundation
import SwiftUI

extension DashboardView {
    
    var infoModalView: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Padding.pt12) {
                    Image(uiImage: R.image.logo_transparent()!)
                        .resizable()
                        .scaledToFit()
                    
                    Divider()
                    
                    rowView(title: R.string.localizable.about_made_by(), value: Constants.authorName, url: Constants.authorWebsiteURL)
                    
                    Divider()
                    
                    rowView(title: R.string.localizable.about_data_source(), value: Constants.dataSourceURLString, url: Constants.dataSourceURL)
                    
                    Divider()
                    
                    if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                        rowView(title: R.string.localizable.about_app_version(), value: appVersion)
                    }
                    
                }
                .padding(Padding.pt16)
            }
            .navigationTitle(R.string.localizable.about_title())
            .navigationBarTitleDisplayMode(.inline)
            .presentationBackground(.thinMaterial)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        viewModel.isInfoPresented = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                }
            }
        }
        
    }
    
    private func rowView(title: String, value: String, url: URL? = nil) -> some View {
        VStack(alignment: .leading, spacing: Padding.pt4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        
            if let url = url {
                Link(destination: url) {
                    Text(value)
                        .multilineTextAlignment(.leading)
                }
            } else {
                Text(value)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}
