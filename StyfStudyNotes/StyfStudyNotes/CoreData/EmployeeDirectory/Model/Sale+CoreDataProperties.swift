//
//  Sale+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/18.
//
//

import Foundation
import CoreData


extension Sale {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sale> {
        return NSFetchRequest<Sale>(entityName: "Sale")
    }

    @NSManaged public var amount: Int16
    @NSManaged public var date: Date?
    @NSManaged public var employee: Employee?

}
