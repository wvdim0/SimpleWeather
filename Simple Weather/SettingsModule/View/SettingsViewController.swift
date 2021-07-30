//
//  SettingsViewController.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 23.07.2021.
//

import UIKit

protocol SettingsViewProtocol: class {
    func updateImageView(with image: UIImage)
}

final class SettingsViewController: UIViewController, SettingsViewProtocol {
    // MARK: - Properties

    var settingsViewPresenter: SettingsViewPresenterProtocol!

    // MARK: - UI

    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)

        blurView.translatesAutoresizingMaskIntoConstraints = false

        return blurView
    }()

    private let settingsView: UIView = {
        let settingsView = UIView()

        settingsView.backgroundColor = Constants.Colors.mainBackgroundColor
        settingsView.layer.cornerRadius = 20
        settingsView.translatesAutoresizingMaskIntoConstraints = false

        return settingsView
    }()

    private let settingsViewTitleLabel: UILabel = {
        let settingsViewTitleLabel = UILabel()

        settingsViewTitleLabel.text = "Место по умолчанию"
        settingsViewTitleLabel.font = UIFont(name: "Avenir Next Bold", size: 18)
        settingsViewTitleLabel.textAlignment = .center
        settingsViewTitleLabel.textColor = .white
        settingsViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        return settingsViewTitleLabel
    }()

    private let defaultPlaceLabel: UILabel = {
        let defaultPlaceLabel = UILabel()

        defaultPlaceLabel.text = UDef.defaultPlace ?? "Мое местоположение"
        defaultPlaceLabel.font = UIFont(name: "Avenir Next", size: 18)
        defaultPlaceLabel.textAlignment = .center
        defaultPlaceLabel.adjustsFontSizeToFitWidth = true
        defaultPlaceLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        defaultPlaceLabel.translatesAutoresizingMaskIntoConstraints = false

        return defaultPlaceLabel
    }()

    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()

        closeButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeSettingsViewController), for: .touchUpInside)

        return closeButton
    }()

    private lazy var myLocationButton: UIButton = {
        let myLocationButton = UIButton()

        myLocationButton.setTitle("Мое местоположение", for: .normal)
        myLocationButton.titleLabel?.textColor = .white
        myLocationButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)
        myLocationButton.backgroundColor = Constants.Colors.darkColor
        myLocationButton.layer.cornerRadius = 10
        myLocationButton.translatesAutoresizingMaskIntoConstraints = false
        myLocationButton.addTarget(self, action: #selector(myLocationButtonTouched), for: .touchDown)
        myLocationButton.addTarget(self, action: #selector(myLocationButtonReleased), for: .touchUpInside)
        myLocationButton.addTarget(self, action: #selector(myLocationButtonReleased), for: .touchUpOutside)

        return myLocationButton
    }()

    private lazy var manualInputButton: UIButton = {
        let manualInputButton = UIButton()

        manualInputButton.setTitle("Ручной ввод", for: .normal)
        manualInputButton.titleLabel?.textColor = .white
        manualInputButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)
        manualInputButton.backgroundColor = Constants.Colors.darkColor
        manualInputButton.layer.cornerRadius = 10
        manualInputButton.translatesAutoresizingMaskIntoConstraints = false
        manualInputButton.addTarget(self, action: #selector(manualInputButtonTouched), for: .touchDown)
        manualInputButton.addTarget(self, action: #selector(manualInputButtonReleased), for: .touchUpInside)
        manualInputButton.addTarget(self, action: #selector(manualInputButtonReleased), for: .touchUpOutside)

        return manualInputButton
    }()

    private lazy var chooseOnMapButton: UIButton = {
        let chooseOnMapButton = UIButton()

        chooseOnMapButton.setTitle("Выбор на карте", for: .normal)
        chooseOnMapButton.titleLabel?.textColor = .white
        chooseOnMapButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)
        chooseOnMapButton.backgroundColor = Constants.Colors.darkColor
        chooseOnMapButton.layer.cornerRadius = 10
        chooseOnMapButton.translatesAutoresizingMaskIntoConstraints = false
        chooseOnMapButton.addTarget(self, action: #selector(chooseOnMapButtonTouched), for: .touchDown)
        chooseOnMapButton.addTarget(self, action: #selector(chooseOnMapButtonReleased), for: .touchUpInside)
        chooseOnMapButton.addTarget(self, action: #selector(chooseOnMapButtonReleased), for: .touchUpOutside)

        return chooseOnMapButton
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let copyrightLabel: UILabel = {
        let copyrightLabel = UILabel()

        copyrightLabel.text = "BY WVDIM"
        copyrightLabel.font = UIFont(name: "Avenit Next", size: 14)
        copyrightLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        copyrightLabel.textAlignment = .center
        copyrightLabel.alpha = 0
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false

        return copyrightLabel
    }()

    private lazy var swipeToRight: UISwipeGestureRecognizer = {
        let swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(closeSettingsViewController))

        swipeToRight.direction = .right

        return swipeToRight
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        view.addGestureRecognizer(swipeToRight)
        view.addSubview(blurView)
        view.addSubview(closeButton)
        view.addSubview(settingsView)
        view.addSubview(imageView)
        view.addSubview(copyrightLabel)

        settingsView.addSubview(settingsViewTitleLabel)
        settingsView.addSubview(defaultPlaceLabel)
        settingsView.addSubview(myLocationButton)
        settingsView.addSubview(manualInputButton)
        settingsView.addSubview(chooseOnMapButton)

        setupConstraints()
        alsoSetupConstraints()

        settingsViewPresenter.loadImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.45, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
                       options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }

            self.settingsView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        }
    }

    // MARK: - Layout

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            closeButton.widthAnchor.constraint(equalToConstant: 22),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            settingsView.widthAnchor.constraint(equalToConstant: view.frame.width - 60),
            settingsView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
            settingsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            settingsView.bottomAnchor.constraint(equalTo: chooseOnMapButton.bottomAnchor, constant: 15),

            settingsViewTitleLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 15),
            settingsViewTitleLabel.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -15),
            settingsViewTitleLabel.heightAnchor.constraint(equalToConstant: 18),
            settingsViewTitleLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 20),

            defaultPlaceLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 15),
            defaultPlaceLabel.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -15),
            defaultPlaceLabel.heightAnchor.constraint(equalToConstant: 20),
            defaultPlaceLabel.topAnchor.constraint(equalTo: settingsViewTitleLabel.bottomAnchor, constant: 9),

            myLocationButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 15),
            myLocationButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -15),
            myLocationButton.heightAnchor.constraint(equalToConstant: 50),
            myLocationButton.topAnchor.constraint(equalTo: defaultPlaceLabel.bottomAnchor, constant: 14),

            manualInputButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 15),
            manualInputButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -15),
            manualInputButton.heightAnchor.constraint(equalToConstant: 50),
            manualInputButton.topAnchor.constraint(equalTo: myLocationButton.bottomAnchor, constant: 10),

            chooseOnMapButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 15),
            chooseOnMapButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -15),
            chooseOnMapButton.heightAnchor.constraint(equalToConstant: 50),
            chooseOnMapButton.topAnchor.constraint(equalTo: manualInputButton.bottomAnchor, constant: 10)
        ])
    }

    private func alsoSetupConstraints() {
        NSLayoutConstraint.activate([
            copyrightLabel.widthAnchor.constraint(equalToConstant: 83),
            copyrightLabel.heightAnchor.constraint(equalToConstant: 14),
            copyrightLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            copyrightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -9.5),

            imageView.widthAnchor.constraint(equalToConstant: 14),
            imageView.heightAnchor.constraint(equalToConstant: 14),
            imageView.centerYAnchor.constraint(equalTo: copyrightLabel.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: copyrightLabel.trailingAnchor, constant: 5)
        ])
    }

    // MARK: - SettingsViewProtocol conforming

    func updateImageView(with image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.imageView.image = image

            UIView.animate(withDuration: 0.55) { [weak self] in
                guard let self = self else { return }

                self.imageView.alpha = 1
                self.copyrightLabel.alpha = 1
            }
        }
    }

    // MARK: - Private methods

    @objc
    private func myLocationButtonTouched() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }

            self.myLocationButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    @objc
    private func myLocationButtonReleased() {
        closeSettingsViewController()

        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }

            self.myLocationButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) { [weak self] in
            guard let self = self else { return }

            self.settingsViewPresenter.getWeather(for: .location)
        }
    }

    @objc
    private func manualInputButtonTouched() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }

            self.manualInputButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    @objc
    private func manualInputButtonReleased() {
        closeSettingsViewController()

        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }

            self.manualInputButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) { [weak self] in
            guard let self = self else { return }

            self.settingsViewPresenter.displayManualInputAlert()
        }
    }

    @objc
    private func chooseOnMapButtonTouched() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }

            self.chooseOnMapButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    @objc
    private func chooseOnMapButtonReleased() {
        closeSettingsViewController()

        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }

            self.chooseOnMapButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) { [weak self] in
            guard let self = self else { return }

            self.settingsViewPresenter.displayMapViewController()
        }
    }

    @objc
    private func closeSettingsViewController() {
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
                       options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }

            self.settingsView.transform = CGAffineTransform(translationX: 0, y: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }

            self.dismiss(animated: true, completion: nil)
        }
    }
}
