//
//  CoreDataStack.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 22.07.2021.
//

import Foundation
import CoreData

final class CoreDataStack {
    // MARK: - Properties

    static let shared = CoreDataStack()

    private let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SimpleWeather")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }

        return container
    }()

    lazy var viewContext = container.viewContext
    lazy var backgroundContext = container.newBackgroundContext()
    lazy var coordinator = container.persistentStoreCoordinator

    // MARK: - Init

    private init() {}
}
