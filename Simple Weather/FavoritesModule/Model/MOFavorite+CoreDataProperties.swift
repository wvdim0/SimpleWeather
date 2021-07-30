//
//  MOFavorite+CoreDataProperties.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 22.07.2021.
//
//

import Foundation
import CoreData

extension MOFavorite {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOFavorite> {
        return NSFetchRequest<MOFavorite>(entityName: "MOFavorite")
    }

    @NSManaged public var name: String
}

extension MOFavorite: Identifiable {}
