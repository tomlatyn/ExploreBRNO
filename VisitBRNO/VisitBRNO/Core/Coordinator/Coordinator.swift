//
//  Coordinator.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI
import UIKit

public typealias Completion = (() -> Void)

public protocol Coordinator: AnyObject {

    @MainActor var navigationController: UINavigationController { get }
    @MainActor var onDismiss: Completion? { get set }

    @MainActor func start()

    @MainActor func push(_ viewController: UIViewController, animated: Bool)
    @MainActor func pop(animated: Bool)
    @MainActor func popTo(_ viewController: UIViewController, animated: Bool)
    @MainActor func popToRoot(animated: Bool)

    @MainActor func present(_ coordinator: Coordinator, style: UIModalPresentationStyle, onDismiss: Completion?, animated: Bool)
    @MainActor func dismiss(animated: Bool, completion: @escaping () -> Void)

    @MainActor func addOverlay(_ viewController: UIViewController, for duration: TimeInterval)
    @MainActor func removeOverlay(at: Int?, for duration: TimeInterval)
}

public extension Coordinator {

    @MainActor func push<V: View>(_ view: V, animated: Bool) {
        push(UIHostingController(rootView: view), animated: animated)
    }

    @MainActor func push<V: View>(_ view: V) {
        push(UIHostingController(rootView: view), animated: true)
    }

    @MainActor func push(_ viewController: UIViewController, animated: Bool = true) {
        push(viewController, animated: animated)
    }

    @MainActor func pop() {
        pop(animated: true)
    }

    @MainActor func popTo(_ viewController: UIViewController) {
        popTo(viewController, animated: true)
    }

    @MainActor func popToRoot() {
        popToRoot(animated: true)
    }

    @MainActor func present(_ coordinator: Coordinator, style: UIModalPresentationStyle = .automatic, onDismiss: Completion? = nil) {
        present(coordinator, style: style, onDismiss: onDismiss, animated: true)
    }

    @MainActor func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        dismiss(animated: animated, completion: completion)
    }

    @MainActor func addOverlay(_ viewController: UIViewController, for duration: TimeInterval = 0.15) {
        addOverlay(viewController, for: duration)
    }

    @MainActor func removeOverlay(at: Int? = nil, for duration: TimeInterval = 0.15) {
        removeOverlay(at: at, for: duration)
    }
}
