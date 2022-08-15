//
//  PriceInfo+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/12.
//
//

import Foundation
import CoreData


extension PriceInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PriceInfo> {
        return NSFetchRequest<PriceInfo>(entityName: "PriceInfo")
    }

    @NSManaged public var priceCategory: String?
    @NSManaged public var venue: Venue?

}
