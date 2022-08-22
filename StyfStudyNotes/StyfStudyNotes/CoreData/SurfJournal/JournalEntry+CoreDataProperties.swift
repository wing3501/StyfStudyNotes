//
//  JournalEntry+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/22.
//
//

import Foundation
import CoreData


extension JournalEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var height: String?
    @NSManaged public var location: String?
    @NSManaged public var period: String?
    @NSManaged public var rating: Int16
    @NSManaged public var wind: String?

}
