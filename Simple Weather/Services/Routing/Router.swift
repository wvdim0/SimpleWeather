//
//  Router.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 25.07.2021.
//

import UIKit

protocol RouterProtocol {
    func setViewControllerAsRootInNavigationController()
    func getSettingsViewController() -> UIViewController
    func getFavoritesViewController() -> UIViewController
    func pushMapViewController()
    func popMapViewController()
}

final class Router: RouterProtocol {
    // MARK: - Properties

    var navigationController: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol

    // MARK: - RouterProtocol conforming methods

    func setViewControllerAsRootInNavigationController() {
        let viewController = assemblyBuilder.getMainModule(router: self)

        navigationController.viewControllers = [viewController]
    }

    func getSettingsViewController() -> UIViewController {
        let settingsViewController = assemblyBuilder.getSettingsModule(router: self)

        return settingsViewController
    }

    func getFavoritesViewController() -> UIViewController {
        let favoritesViewController = assemblyBuilder.getFavoritesModule(router: self)

        return favoritesViewController
    }

    func pushMapViewController() {
        let mapViewController = assemblyBuilder.getMapModule(router: self)

        navigationController.pushViewController(mapViewController, animated: true)
    }

    func popMapViewController() {
        navigationController.popViewController(animated: true)
    }

    // MARK: - Init

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
}
