//
//  FavoritesViewController.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 27.06.2021.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func displayErrorAlert(with title: String)
    func addFavoritePlace()
    func deleteFavoritePlace(at index: Int)
    func displayEmptyTableMessage()
    func hideEmptyTableMessage()
}

final class FavoritesViewController: UIViewController, FavoritesViewProtocol {
    // MARK: - Properties

    var favoritesViewPresenter: FavoritesViewPresenterProtocol!

    // MARK: - UI

    private let containerView: UIView = {
        let containerView = UIView()

        containerView.backgroundColor = Constants.Colors.mainBackgroundColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        return containerView
    }()

    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeFavoritesViewController), for: .touchUpInside)

        return closeButton
    }()

    private let headerBackgroundView: UIView = {
        let headerBackgroundView = UIView()

        headerBackgroundView.backgroundColor = Constants.Colors.middleColor
        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        return headerBackgroundView
    }()

    private let headerLabel: UILabel = {
        let headerLabel = UILabel()

        headerLabel.text = "Избранное"
        headerLabel.font = UIFont(name: "Avenir Next Bold", size: 30)
        headerLabel.textAlignment = .left
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        return headerLabel
    }()

    private lazy var addFavoritePlaceButton: UIButton = {
        let addFavoritePlaceButton = UIButton()

        addFavoritePlaceButton.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        addFavoritePlaceButton.tintColor = .white
        addFavoritePlaceButton.translatesAutoresizingMaskIntoConstraints = false
        addFavoritePlaceButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        return addFavoritePlaceButton
    }()

    private let sadSmileImageView: UIImageView = {
        let sadSmileImageView = UIImageView()

        sadSmileImageView.image = UIImage(named: "SadSmile")
        sadSmileImageView.contentMode = .scaleAspectFill
        sadSmileImageView.isHidden = true
        sadSmileImageView.translatesAutoresizingMaskIntoConstraints = false

        return sadSmileImageView
    }()

    private let emptyHereLabel: UILabel = {
        let emptyHereLabel = UILabel()

        emptyHereLabel.text = "Здесь пусто"
        emptyHereLabel.font = UIFont(name: "Avenir Next", size: 18)
        emptyHereLabel.textAlignment = .center
        emptyHereLabel.isHidden = true
        emptyHereLabel.translatesAutoresizingMaskIntoConstraints = false

        return emptyHereLabel
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = Constants.Colors.lightColor
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.cellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)

        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.backgroundColor = Constants.Colors.darkColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        return activityIndicator
    }()

    private lazy var leftSwipe: UISwipeGestureRecognizer = {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(closeFavoritesViewController))

        leftSwipe.direction = .left

        return leftSwipe
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addGestureRecognizer(leftSwipe)
        view.addSubview(containerView)
        view.addSubview(closeButton)

        containerView.addSubview(headerBackgroundView)
        containerView.addSubview(headerLabel)
        containerView.addSubview(addFavoritePlaceButton)
        containerView.addSubview(sadSmileImageView)
        containerView.addSubview(emptyHereLabel)
        containerView.addSubview(tableView)
        containerView.addSubview(activityIndicator)

        setupConstraints()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let bottomBorder = CALayer()

        bottomBorder.frame = CGRect(x: 0, y: headerBackgroundView.frame.maxY,
                                    width: headerBackgroundView.frame.width, height: 0.5)
        bottomBorder.backgroundColor = Constants.Colors.lightColor.cgColor

        headerBackgroundView.layer.addSublayer(bottomBorder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.35, delay: 0.05, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }

            self.containerView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
        }
    }

    // MARK: - Layout

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -view.frame.width),
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            closeButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            headerBackgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            headerBackgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            headerLabel.trailingAnchor.constraint(equalTo: addFavoritePlaceButton.leadingAnchor, constant: -15),
            headerLabel.heightAnchor.constraint(equalToConstant: 30),
            headerLabel.bottomAnchor.constraint(equalTo: headerBackgroundView.bottomAnchor, constant: -10),

            addFavoritePlaceButton.heightAnchor.constraint(equalToConstant: 25),
            addFavoritePlaceButton.widthAnchor.constraint(equalToConstant: 25),
            addFavoritePlaceButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            addFavoritePlaceButton.bottomAnchor.constraint(equalTo: headerLabel.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: headerBackgroundView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            sadSmileImageView.widthAnchor.constraint(equalToConstant: 100),
            sadSmileImageView.heightAnchor.constraint(equalToConstant: 100),
            sadSmileImageView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            sadSmileImageView.bottomAnchor.constraint(equalTo: tableView.centerYAnchor),

            emptyHereLabel.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 15),
            emptyHereLabel.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -15),
            emptyHereLabel.heightAnchor.constraint(equalToConstant: 18),
            emptyHereLabel.topAnchor.constraint(equalTo: sadSmileImageView.bottomAnchor, constant: 15),

            activityIndicator.widthAnchor.constraint(equalToConstant: 80),
            activityIndicator.heightAnchor.constraint(equalTo: activityIndicator.widthAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }

    // MARK: - FavoritesViewProtocol conforming methods

    func startLoadingAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.view.isUserInteractionEnabled = false

            self.activityIndicator.startAnimating()
        }
    }

    func stopLoadingAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.view.isUserInteractionEnabled = true

            self.activityIndicator.stopAnimating()
        }
    }

    func addFavoritePlace() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let favoritePlaces = self.favoritesViewPresenter.getFavoritePlacesFromCoreData()
            let indexPath: IndexPath = [0, favoritePlaces.count - 1]

            self.tableView.insertRows(at: [indexPath], with: .left)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    func deleteFavoritePlace(at index: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.tableView.deleteRows(at: [[0, index]], with: .left)
        }
    }

    func displayErrorAlert(with title: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)

            alert.addAction(okAction)

            self.present(alert, animated: true)
        }
    }

    func displayEmptyTableMessage() {
        sadSmileImageView.isHidden = false
        emptyHereLabel.isHidden = false
    }

    func hideEmptyTableMessage() {
        sadSmileImageView.isHidden = true
        emptyHereLabel.isHidden = true
    }

    // MARK: - Private methods

    @objc
    private func addButtonTapped() {
        let alert = UIAlertController(title: "Введите название места", message: nil, preferredStyle: .alert)
        alert.addTextField()

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }

            self.favoritesViewPresenter.addFavoritePlaceToCoreData(with: alert.textFields?.first?.text)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    @objc func closeFavoritesViewController() {
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }

            self.containerView.transform = CGAffineTransform(translationX: 0, y: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
            guard let self = self else { return }

            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITablewViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favoritePlaces = favoritesViewPresenter.getFavoritePlacesFromCoreData()

        return favoritePlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var favoriteCell = FavoriteCell()

        if let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellID) as? FavoriteCell {
            favoriteCell = cell
        }

        let favoritePlaces = favoritesViewPresenter.getFavoritePlacesFromCoreData()

        favoriteCell.configure(with: favoritePlaces[indexPath.row])

        return favoriteCell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        favoritesViewPresenter.deletePlaceFromCoreData(at: indexPath.row)
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        closeFavoritesViewController()
        favoritesViewPresenter.getWeatherForSelectedRow(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView,
                   titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
}
