//
//  URLImageView.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 06.05.2025.
//

import Foundation
import Kingfisher
import SwiftUI

public struct URLImageView: View {
    let url: URL
    let imageScaling: SwiftUI.ContentMode
    @State var isLoading = true

    /// Primary View for showing images
    public init(
        url: URL,
        imageScaling: SwiftUI.ContentMode = .fit
    ) {
        self.url = url
        self.imageScaling = imageScaling
    }
    
    public var body: some View {
        ZStack {
            KFImage(url)
                .placeholder {
                    Rectangle()
                        .fill(.primary.opacity(0.25))
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .cornerRadius(8)
                }
                .retry(maxCount: 3, interval: .seconds(1))
                .onFailure { e in
                    isLoading = false
                    print("KingfisherError: \(e)")
                }
                .onSuccess { _ in
                    isLoading = false
                }
                .cancelOnDisappear(true)
                .cacheOriginalImage()
                .diskCacheExpiration(.days(60))
                .memoryCacheExpiration(.seconds(600))
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: imageScaling)
                .cornerRadius(8)

            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            }
        }
//        .animation(nil, value: true)
    }
}
