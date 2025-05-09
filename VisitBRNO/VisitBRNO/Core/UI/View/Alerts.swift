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
            title: Text(R.string.localizable.alert_connection_error_title()),
            message: Text(R.string.localizable.alert_connection_error_message),
            primaryButton: .default(Text(R.string.localizable.try_again), action: onRetry),
            secondaryButton: .cancel(onCancel)
        )
    }

    public static func generalErrorAlert(onRetry: @escaping () -> Void, onCancel: (() -> Void)? = nil) -> Alert {
        Alert(
            title: Text(R.string.localizable.alert_general_error_title),
            message: Text(R.string.localizable.alert_general_error_message),
            primaryButton: .default(Text(R.string.localizable.try_again), action: onRetry),
            secondaryButton: .cancel(onCancel)
        )
    }
    
}
