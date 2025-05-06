//
//  LoadingView.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 07.05.2025.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(2.0)
            .frame(width: 64, height: 64)
            .background(
                .thinMaterial
            )
            .cornerRadius(16)
    }
}
