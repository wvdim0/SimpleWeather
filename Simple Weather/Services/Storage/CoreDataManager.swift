//
//  CoreDataManager.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 21.07.2021.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func addFavoritePlace(with name: String)
    func deleteFavoritePlace(at index: Int)
    func getFavoritePlaces() -> [String]
}

final class CoreDataManager: CoreDataManagerProtocol {
    // MARK: - Properties

    private let coreDataStack = CoreDataStack.shared

    // MARK: - CoreDataManagerProtocol conforming methods

    func addFavoritePlace(with name: String) {
        coreDataStack.backgroundContext.performAndWait {
            let newFavoritePlace = MOFavorite(context: coreDataStack.backgroundContext)

            newFavoritePlace.name = name

            try? coreDataStack.backgroundContext.save()
        }
    }

    func deleteFavoritePlace(at index: Int) {
        coreDataStack.backgroundContext.performAndWait {
            let request = NSFetchRequest<MOFavorite>(entityName: "MOFavorite")

            if let result = try? request.execute() {
                coreDataStack.backgroundContext.delete(result[index])
            }

            try? coreDataStack.backgroundContext.save()
        }
    }

    func getFavoritePlaces() -> [String] {
        var favoritePlaces = [String]()

        coreDataStack.viewContext.performAndWait {
            let request = NSFetchRequest<MOFavorite>(entityName: "MOFavorite")
            let result = try? request.execute()

            result?.forEach {
                favoritePlaces.append($0.name)
            }
        }

        return favoritePlaces
    }
}
