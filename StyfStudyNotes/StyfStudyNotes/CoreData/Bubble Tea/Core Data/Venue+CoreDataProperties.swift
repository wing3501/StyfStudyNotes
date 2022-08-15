//
//  Venue+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/12.
//
//

import Foundation
import CoreData


extension Venue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var specialCount: Int32
    @NSManaged public var category: VenueCategory?
    @NSManaged public var location: VenueLocation?
    @NSManaged public var priceInfo: PriceInfo?
    @NSManaged public var stats: Stats?

}
