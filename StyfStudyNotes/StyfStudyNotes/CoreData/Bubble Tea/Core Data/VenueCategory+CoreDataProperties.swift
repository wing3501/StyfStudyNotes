//
//  VenueCategory+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/12.
//
//

import Foundation
import CoreData


extension VenueCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VenueCategory> {
        return NSFetchRequest<VenueCategory>(entityName: "VenueCategory")
    }

    @NSManaged public var categoryID: String?
    @NSManaged public var name: String?
    @NSManaged public var venue: Venue?

}
