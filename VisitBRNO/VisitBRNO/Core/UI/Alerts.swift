//
//  Alerts.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 07.05.2025.
//

import Foundation
import SwiftUI

public struct Alerts {
 
    public static func connectionErrorAlert(onRetry: @escaping () -> Void, onCancel: (() -> Void)? = nil) -> Alert {
        Alert(
            title: Text("error"),
            message: Text("error"),
            primaryButton: .default(Text("retry"), action: onRetry),
            secondaryButton: .cancel(onCancel)
        )
    }

    public static func generalErrorAlert(onRetry: @escaping () -> Void, onCancel: (() -> Void)? = nil) -> Alert {
        Alert(
            title: Text("error"),
            message: Text("error"),
            primaryButton: .default(Text("retry"), action: onRetry),
            secondaryButton: .cancel(onCancel)
        )
    }
    
}
