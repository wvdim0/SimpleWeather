//
//  SettingsViewPresenter.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 25.07.2021.
//

import UIKit

protocol SettingsViewPresenterProtocol {
    func getWeather(for requestType: RequestType)
    func loadImage()
    func displayMapViewController()
    func displayManualInputAlert()
}

final class SettingsViewPresenter: SettingsViewPresenterProtocol {
    // MARK: - Properties

    weak private var settingsView: SettingsViewProtocol?
    weak private var viewPresenter: ViewPresenterProtocol?

    private let networkManager: NetworkManagerProtocol
    private let router: RouterProtocol

    // MARK: - SettingsViewPresenterProtocol conforming methods

    func getWeather(for requestType: RequestType) {
        viewPresenter?.getWeather(for: requestType)
    }

    func loadImage() {
        networkManager.loadImage { [weak self] data in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else { return }

            self.settingsView?.updateImageView(with: image)
        }
    }

    func displayMapViewController() {
        viewPresenter?.displayMapViewController()
    }

    func displayManualInputAlert() {
        viewPresenter?.displayManualInputAlert()
    }

    // MARK: - Init

    init(settingsView: SettingsViewProtocol, viewPresenter: ViewPresenterProtocol?,
         networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.settingsView = settingsView
        self.viewPresenter = viewPresenter
        self.networkManager = networkManager
        self.router = router
    }
}
