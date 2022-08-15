//
//  VenueLocation+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/12.
//
//

import Foundation
import CoreData


extension VenueLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VenueLocation> {
        return NSFetchRequest<VenueLocation>(entityName: "VenueLocation")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var distance: Float
    @NSManaged public var state: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var venue: Venue?

}
