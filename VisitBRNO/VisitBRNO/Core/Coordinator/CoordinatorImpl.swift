//
//  CoordinatorImpl.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI

open class CoordinatorImpl: NSObject, Coordinator {

    // MARK: - Properties

    public var navigationController: UINavigationController
    public var onDismiss: Completion?
    @MainActor private var overlays: [UIViewController] = []

    // MARK: - Lifecycle

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("Coordinator \(String(describing: type(of: self))) was deinitialized.")
    }

    open func start() {
        fatalError("start() must be overridden by subclasses.")
    }

    // MARK: - Navigation

    open func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    open func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    open func popTo(_ viewController: UIViewController, animated: Bool) {
        navigationController.popToViewController(viewController, animated: animated)
    }

    open func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }

    // MARK: - Modal

    public func present(_ coordinator: Coordinator, style: UIModalPresentationStyle, onDismiss: Completion?, animated: Bool) {
        coordinator.onDismiss = onDismiss
        self.onDismiss = onDismiss
        coordinator.navigationController.modalPresentationStyle = style
        coordinator.navigationController.presentationController?.delegate = self
        navigationController.present(coordinator.navigationController, animated: animated)
    }

    public func dismiss(animated: Bool, completion: @escaping () -> Void) {
        navigationController.dismiss(animated: animated, completion: {
            self.onDismiss?()
            completion()
        })
    }

    // MARK: - Overlays

    public func addOverlay(_ viewController: UIViewController, transitionDuration: TimeInterval?) {
        viewController.view.frame = navigationController.view.bounds
        viewController.view.alpha = 0.0
        navigationController.view.addSubview(viewController.view)
        UIView.animate(withDuration: transitionDuration ?? 0.0) {
            viewController.view.alpha = 1.0
        }
        overlays.append(viewController)
    }

    public func removeOverlay(at: Int?, transitionDuration: TimeInterval?) {
        let index = at ?? overlays.endIndex - 1
        guard index >= 0, index < overlays.count else { return }
        let overlay = overlays[index]
        UIView.animate(withDuration: transitionDuration ?? 0.0, animations: {
            overlay.view.alpha = 0.0
        }, completion: { _ in
            overlay.willMove(toParent: nil)
            overlay.view.removeFromSuperview()
            overlay.removeFromParent()
        })
        overlays.removeLast()
    }
}

extension CoordinatorImpl: UIAdaptivePresentationControllerDelegate {

    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onDismiss?()
    }
}
