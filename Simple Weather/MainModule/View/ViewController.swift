//
//  ViewController.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 02.06.2021.
//

import UIKit

protocol ViewProtocol: AnyObject {
    var isLoadingAnimationInProcess: Bool { get }

    func updateInterface(with resultWeather: ResultWeather)
    func displayErrorAlert(with title: String)
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func displayMapViewController()
    func displayManualInputAlert()
}

final class ViewController: UIViewController, ViewProtocol {
    // MARK: - Properties

    var viewPresenter: ViewPresenterProtocol!
    var isLoadingAnimationInProcess = false

    private var resultWeather: ResultWeather?
    private var navigationItemTitleCache = "Демо-режим"

    // MARK: - UI

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()

        refreshControl.addTarget(self, action: #selector(refreshingStarted(sender:)), for: .valueChanged)

        return refreshControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.dataSource = self
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: DailyWeatherCell.cellID)
        tableView.backgroundColor = Constants.Colors.mainBackgroundColor
        tableView.separatorColor = Constants.Colors.lightColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private lazy var swipeToLeft: UISwipeGestureRecognizer = {
        let swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(displaySettingsViewController))

        swipeToLeft.direction = .left

        return swipeToLeft
    }()

    private lazy var swipeToRight: UISwipeGestureRecognizer = {
        let swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(displayFavoritesViewController))

        swipeToRight.direction = .right

        return swipeToRight
    }()

    private let shimmerFakeTableView: ShimmerFakeTableView = {
        let shimmerFakeTableView = ShimmerFakeTableView()

        shimmerFakeTableView.translatesAutoresizingMaskIntoConstraints = false

        return shimmerFakeTableView
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.Colors.mainBackgroundColor
        view.addSubview(tableView)
        view.addSubview(shimmerFakeTableView)
        view.addGestureRecognizer(swipeToLeft)
        view.addGestureRecognizer(swipeToRight)

        setupConstraints()
        setupNavigationBar()

        viewPresenter.getWeather(for: .defaultPlace)
    }

    // MARK: - Layout

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            shimmerFakeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shimmerFakeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shimmerFakeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            shimmerFakeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Setting up navigation bar

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white

        navigationItem.title = navigationItemTitleCache
        let favoritesButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                                           style: .plain, target: self,
                                                           action: #selector(displayFavoritesViewController))

        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                            style: .plain, target: self,
                                                            action: #selector(displaySettingsViewController))

        favoritesButton.accessibilityIdentifier = "favoritesButton"
        settingsButton.accessibilityIdentifier = "settingsButton"

        navigationItem.leftBarButtonItem = favoritesButton
        navigationItem.rightBarButtonItem = settingsButton

        var navigationItemTitleFontSize: CGFloat = 18

        if (UIDevice.modelName == "iPhone SE") || (UIDevice.modelName == "iPod touch 7") {
            navigationItemTitleFontSize = 15
        }

        guard let titleFont = UIFont(name: "Avenir Next", size: navigationItemTitleFontSize) else { return }

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: titleFont]
    }

    // MARK: - ViewProtocol conforming methods

    func startLoadingAnimation() {
        isLoadingAnimationInProcess = true

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.view.isUserInteractionEnabled = false

            self.navigationItem.title?.removeAll()
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.isEnabled = false

            self.shimmerFakeTableView.startShimmerAnimation()

            self.tableView.scrollToRow(at: [0, 0], at: .top, animated: false)
        }
    }

    func stopLoadingAnimation() {
        isLoadingAnimationInProcess = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) { [weak self] in
            guard let self = self else { return }

            self.shimmerFakeTableView.stopShimmerAnimation()

            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.isEnabled = true

            self.view.isUserInteractionEnabled = true
        }
    }

    func updateInterface(with resultWeather: ResultWeather) {
        self.resultWeather = resultWeather

        navigationItemTitleCache = resultWeather.city

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.tableView.reloadData()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) { [weak self] in
            guard let self = self else { return }

            self.navigationItem.title = resultWeather.city
        }
    }

    func displayErrorAlert(with title: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let errorAlert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

            errorAlert.addAction(okAction)

            self.present(errorAlert, animated: true, completion: nil)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) { [weak self] in
            guard let self = self else { return }

            self.navigationItem.title = self.navigationItemTitleCache
        }
    }

    func displayMapViewController() {
        viewPresenter.pushMapViewController()
    }

    func displayManualInputAlert() {
        let manualInputAlert = UIAlertController(title: "Введите название места", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            guard let self = self else { return }

            self.viewPresenter.getWeather(for: .city(manualInputAlert.textFields?.first?.text))
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        manualInputAlert.addTextField()
        manualInputAlert.addAction(okAction)
        manualInputAlert.addAction(cancelAction)

        present(manualInputAlert, animated: true)
    }

    // MARK: - Private methods

    @objc
    private func refreshingStarted(sender: UIRefreshControl) {
        refreshControl.endRefreshing()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) { [weak self] in
            guard let self = self else { return }

            self.viewPresenter.getWeather(for: .currentPlace)
        }
    }

    @objc
    private func displayFavoritesViewController() {
        let favoritesVC = viewPresenter.getFavoritesViewController()

        favoritesVC.modalPresentationStyle = .overFullScreen
        favoritesVC.modalTransitionStyle = .crossDissolve

        present(favoritesVC, animated: true)
    }

    @objc
    private func displaySettingsViewController() {
        let settingsViewController = viewPresenter.getSettingsViewController()

        settingsViewController.modalPresentationStyle = .overFullScreen
        settingsViewController.modalTransitionStyle = .crossDissolve

        present(settingsViewController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (resultWeather?.daily.dates.count ?? 1) + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let currentWeatherCell = CurrentWeatherCell()

            currentWeatherCell.configure(with: resultWeather)

            return currentWeatherCell
        default:
            var dailyWeatherCell = DailyWeatherCell()

            if let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.cellID) as? DailyWeatherCell {
                dailyWeatherCell = cell
            }

            dailyWeatherCell.configure(with: resultWeather, index: indexPath.row - 1)

            return dailyWeatherCell
        }
    }
}
