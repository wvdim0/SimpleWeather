//
//  AppDelegate.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 02.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // CoreDataStack init
        _ = CoreDataStack.shared

        // UserDefaults setting up
        UDef.defaultPlaceCache = nil
        UDef.currentPlaceLatitude = 0.0
        UDef.currentPlaceLongitude = 0.0

        // Router setting up
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)

        router.setViewControllerAsRootInNavigationController()

        // Window setting up
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
