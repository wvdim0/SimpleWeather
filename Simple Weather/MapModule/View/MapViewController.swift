//
//  MapViewController.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 14.06.2021.
//

import UIKit
import MapKit

protocol MapViewProtocol: class {
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func displayLocation(_ location: Location)
    func displayErrorAlert(with title: String)
    func displayAddress(_ address: String)
    func showUserLocationPlacemark()
}

class MapViewController: UIViewController, MapViewProtocol {
    // MARK: - Properties

    var mapViewPresenter: MapViewPresenterProtocol!

    private var centerCoordinate: CLLocationCoordinate2D?

    // MARK: - UI

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()

        mapView.delegate = self
        mapView.isUserInteractionEnabled = false
        mapView.translatesAutoresizingMaskIntoConstraints = false

        return mapView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)

        activityIndicator.backgroundColor = UIColor(red: 64 / 255, green: 72 / 255, blue: 88 / 255, alpha: 1)
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        return activityIndicator
    }()

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()

        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Avenir Next", size: 18)
        textLabel.numberOfLines = 2
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.alpha = 0

        return textLabel
    }()

    private lazy var locationMark: UIImageView = {
        let locationMark = UIImageView()

        locationMark.contentMode = .scaleAspectFit
        locationMark.image = UIImage(systemName: "mappin")
        locationMark.tintColor = .white
        locationMark.alpha = 0
        locationMark.translatesAutoresizingMaskIntoConstraints = false

        return locationMark
    }()

    private let shimmerView: ShimmerView = {
        let shimmerView = ShimmerView()

        shimmerView.backgroundColor = Constants.Colors.middleColor
        shimmerView.layer.cornerRadius = 15
        shimmerView.alpha = 0
        shimmerView.translatesAutoresizingMaskIntoConstraints = false

        return shimmerView
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        view.addSubview(activityIndicator)
        view.addSubview(textLabel)
        view.addSubview(locationMark)
        view.addSubview(shimmerView)

        setupNavigationBar()
        setupConstraints()

        mapViewPresenter.getUserLocation()
    }

    override func viewWillLayoutSubviews() {
        shimmerView.setupGradientLayer()
    }

    // MARK: - Layout

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            activityIndicator.widthAnchor.constraint(equalToConstant: 80),
            activityIndicator.heightAnchor.constraint(equalTo: activityIndicator.widthAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            shimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            shimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            shimmerView.heightAnchor.constraint(equalToConstant: 65),
            shimmerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),

            textLabel.leadingAnchor.constraint(equalTo: shimmerView.leadingAnchor, constant: 15),
            textLabel.trailingAnchor.constraint(equalTo: shimmerView.trailingAnchor, constant: -15),
            textLabel.topAnchor.constraint(equalTo: shimmerView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: shimmerView.bottomAnchor),

            locationMark.widthAnchor.constraint(equalToConstant: 50),
            locationMark.heightAnchor.constraint(equalTo: locationMark.widthAnchor),
            locationMark.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            locationMark.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // MARK: - Setting up navigation bar

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(doneButtonTapped))
    }

    // MARK: - MapViewProtocol conforming methods

    func startLoadingAnimation() {
        activityIndicator.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }

            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    func stopLoadingAnimation() {
        activityIndicator.stopAnimating()
    }

    func displayLocation(_ location: Location) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude,
                                                                       longitude: location.longitude),
                                        latitudinalMeters: 400, longitudinalMeters: 400)

        mapView.setRegion(region, animated: true)
        mapView.isUserInteractionEnabled = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }

                self.shimmerView.alpha = 1
                self.textLabel.alpha = 1
                self.locationMark.alpha = 1
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }

    func displayErrorAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }

            self.mapViewPresenter.errorAlertOKButtonTapped()
        }

        alert.addAction(action)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }

            self.present(alert, animated: true, completion: nil)
        }
    }

    func displayAddress(_ address: String) {
        textLabel.text = address
    }

    func showUserLocationPlacemark() {
        mapView.showsUserLocation = true
    }

    // MARK: - Private methods

    @objc
    private func backButtonTapped() {
        mapView.showsUserLocation = false

        mapViewPresenter.popMapViewController()
    }

    @objc
    private func doneButtonTapped() {
        mapViewPresenter.getWeather(for: centerCoordinate?.latitude, longitude: centerCoordinate?.longitude)
        mapViewPresenter.popMapViewController()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        shimmerView.startShimmerAnimation()

        view.bringSubviewToFront(shimmerView)
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false

        textLabel.text = ""
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        let centerLocation = CLLocation(latitude: latitude, longitude: longitude)

        centerCoordinate = centerLocation.coordinate

        mapViewPresenter.convertLocationToAddress(Location(latitude: latitude, longitude: longitude))

        shimmerView.stopShimmerAnimation()
        navigationItem.leftBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.isEnabled = true

        view.bringSubviewToFront(textLabel)
    }
}
