//
//  Camper+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/18.
//
//

import Foundation
import CoreData


extension Camper {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Camper> {
        return NSFetchRequest<Camper>(entityName: "Camper")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var reservations: Reservation?

}
