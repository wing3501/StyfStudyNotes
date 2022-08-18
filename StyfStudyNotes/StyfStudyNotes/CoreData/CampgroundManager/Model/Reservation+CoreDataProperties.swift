//
//  Reservation+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/18.
//
//

import Foundation
import CoreData


extension Reservation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reservation> {
        return NSFetchRequest<Reservation>(entityName: "Reservation")
    }

    @NSManaged public var dateFrom: Date?
    @NSManaged public var dateTo: Date?
    @NSManaged public var status: String?
    @NSManaged public var camper: Camper?
    @NSManaged public var campSite: CampSite?

}
