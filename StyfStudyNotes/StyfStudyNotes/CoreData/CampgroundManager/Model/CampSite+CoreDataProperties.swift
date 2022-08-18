//
//  CampSite+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/18.
//
//

import Foundation
import CoreData


extension CampSite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CampSite> {
        return NSFetchRequest<CampSite>(entityName: "CampSite")
    }

    @NSManaged public var electricity: Bool
    @NSManaged public var siteNumber: Int16
    @NSManaged public var water: Bool
    @NSManaged public var reservations: Reservation?

}
