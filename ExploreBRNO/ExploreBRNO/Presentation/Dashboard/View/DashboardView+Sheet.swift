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
                VStack(alignment: .leading, spacing: 12) {
                    Image(uiImage: R.image.logo_transparent()!)
                        .resizable()
                        .scaledToFit()
                    
                    Divider()
                    
                    rowView(title: "Made By", value: "Tomáš Latýn", url: URL(string: "https://tomaslatyn.xyz/"))
                    
                    Divider()
                    
                    rowView(title: "Data Source", value: "data.brno.cz", url: URL(string: "https://data.brno.cz/"))
                    
                    Divider()
                    
                    if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                        rowView(title: "App Version", value: appVersion)
                    }
                    
                }
                .padding(16)
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
        VStack(alignment: .leading, spacing: 4) {
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
