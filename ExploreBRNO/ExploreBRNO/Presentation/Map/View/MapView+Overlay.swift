//
//  MapView+Overlay.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 09.05.2025.
//

import Foundation
import SwiftUI
import MapKit

extension MapView {
    
    // MARK: - Map controls
    
    var closestLocationButton: some View {
        Button(R.string.localizable.map_find_nearest_location()) {
            viewModel.selectClosestLocation()
        }
        .padding(.horizontal, Padding.pt12)
        .padding(.vertical, Padding.pt6)
        .background(colorScheme == .dark ? .black.opacity(0.8) : .white.opacity(0.8))
        .cornerRadius(CornerRadius.pt6)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, Padding.pt12)
    }
    
    var mapFilterView: some View {
        VStack(spacing: Padding.pt12) {
            Toggle(
                R.string.localizable.map_filter_bookmark(),
                isOn: $viewModel.bookmarkFilterToggle
            )
            .tint(Color(R.color.primary()!))
            
            Divider()
            
            VStack(spacing: Padding.pt12) {
                ForEach(viewModel.mapLocationTypes, id: \.self) { type in
                    Text(type.collectionName)
                        .foregroundStyle(.white)
                        .padding(Padding.pt12)
                        .frame(maxWidth: .infinity)
                        .background(Color(type.color))
                        .opacity(viewModel.selectedMapLocationTypes.contains(type) ? 1 : 0.35)
                        .clipShape(.capsule)
                        .onTapGesture {
                            viewModel.toggleMapLocationType(type: type)
                        }
                }
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding(Padding.pt12)
    }
    
    // MARK: - Cluster list
    
    var clusterListPopover: some View {
        Color.clear
            .frame(width: 1, height: 1)
            .popover(isPresented: $viewModel.isClusterListPresented, arrowEdge: .top) {
                clusterList
                    .presentationSizing(.fitted)
                    .presentationCompactAdaptation(.popover)
            }
    }
    
    private var clusterList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Padding.pt12) {
                ForEach(viewModel.clusterLocations, id: \.location.id) { location in
                    HStack {
                        VStack(alignment: .leading, spacing: Padding.pt2) {
                            Text(location.location.model.name)
                            
                            Text(location.location.type.name)
                                .foregroundStyle(Color(location.location.type.color))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "chevron.right")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectLocation(location.location)
                    }
                    
                    if location != viewModel.clusterLocations.last {
                        Divider()
                    }
                }
            }
            .padding(Padding.pt16)
        }
    }
    
}
