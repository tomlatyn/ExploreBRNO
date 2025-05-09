//
//  ButtonLarge.swift
//  ExploreBRNO
//
//  Created by Tomáš Latýn on 09.05.2025.
//

import SwiftUI

struct ButtonLarge: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.vertical, Padding.pt16)
                .padding(.horizontal, Padding.pt24)
                .frame(maxWidth: .infinity)
                .background(Color(R.color.primary()!))
        }
        .cornerRadius(CornerRadius.pt12)
    }
}
