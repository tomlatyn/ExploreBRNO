//
//  LoadingView.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 07.05.2025.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var text: String?
    
    var body: some View {
        VStack(spacing: Padding.pt24) {
            ProgressView()
                .scaleEffect(1.5)
            
            if let text = text {
                Text(text)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(Padding.pt32)
        .background(
            .ultraThinMaterial
        )
        .cornerRadius(CornerRadius.pt16)
            
    }
}
