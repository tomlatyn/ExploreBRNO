//
//  AppDelegate.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?
    lazy var appDI = AppDI()

    // MARK: - Application state

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
        let appCoordinator = appDI.container.resolve(AppCoordinator.self)!
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.navigationController
        window?.makeKeyAndVisible()
        
        appCoordinator.start()
        
        return true
    }

}
