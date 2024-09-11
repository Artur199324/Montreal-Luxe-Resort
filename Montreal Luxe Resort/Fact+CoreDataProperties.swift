//
//  Fact+CoreDataProperties.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//
//

import Foundation
import CoreData


extension Fact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fact> {
        return NSFetchRequest<Fact>(entityName: "Fact")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var photo: Data?
    @NSManaged public var title: String?

}

extension Fact : Identifiable {

}
