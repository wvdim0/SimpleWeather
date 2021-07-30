//
//  SimpleWeatherSnapshotTests.swift
//  SimpleWeatherSnapshotTests
//
//  Created by Вадим Аписов on 29.07.2021.
//

import XCTest
import SnapshotTesting

@testable import Simple_Weather

class SimpleWeatherSnapshotTests: XCTestCase {
    private var settingsView: UIViewController!

    private var router = Router(navigationController: UINavigationController(),
                                assemblyBuilder: AssemblyBuilder())

    override func setUpWithError() throws {
        try super.setUpWithError()

        settingsView = router.getSettingsViewController()
    }

    func testThatSettingsViewSnapshotLooksLikeRealSettingsViewController() {
        assertSnapshot(matching: settingsView, as: .image(on: .iPhoneXr))
    }
}
