//
//  Notes+CoreDataProperties.swift
//  Notes
//
//  Created by Флора Гарифуллина on 30.01.2024.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var text: String?
    @NSManaged public var tittle: String?
    @NSManaged public var topic: String?

}

extension Notes : Identifiable {

}
