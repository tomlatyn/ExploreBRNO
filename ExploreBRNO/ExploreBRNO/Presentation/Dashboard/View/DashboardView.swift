//
//  DashboardView.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI

public struct DashboardView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: DashboardViewModel
    let coordinator: DashboardCoordinator
    
    // MARK: - Lifecycle
    
    public init(
        viewModel: DashboardViewModel,
        coordinator: DashboardCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    // MARK: - Layout
    
    public var body: some View {
        ZStack {
            Color(R.color.background()!)
                .ignoresSafeArea()
            
            layoutMain
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    viewModel.isInfoPresented = true
                }, label: {
                    Image(systemName: "info.circle")
                })
            }
        }
        .sheet(isPresented: $viewModel.isInfoPresented) {
            infoModalView
        }
    }
    
    @ViewBuilder
    private var layoutMain: some View {
        ScrollView {
            VStack(spacing: Padding.pt12) {
                ForEach(MapType.allCases, id: \.self) { type in
                    itemRow(type: type)
                    
                    if type != MapType.allCases.last {
                        Divider()
                    }
                }
            }
            .padding(Padding.pt16)
        }
    }
    
    private func itemRow(type: MapType) -> some View {
        HStack(spacing: Padding.pt12) {
            type.icon
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 16)
                .foregroundStyle(Color(.primary))
            
            Text(type.navigationTitle)
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "chevron.forward")
                .resizable()
                .scaledToFit()
                .frame(height: 16)
                .foregroundStyle(Color(.primary))
        }
        .padding(Padding.pt16)
        .contentShape(Rectangle())
        .onTapGesture {
            coordinator.navigate(.map(type))
        }
    }
}
