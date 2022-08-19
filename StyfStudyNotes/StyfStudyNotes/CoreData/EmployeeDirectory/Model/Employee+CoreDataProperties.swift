//
//  Employee+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/18.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var about: String?
    @NSManaged public var active: Bool
    @NSManaged public var address: String?
    @NSManaged public var department: String?
    @NSManaged public var email: String?
    @NSManaged public var guid: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var picture: Data?
    @NSManaged public var startDate: Date?
    @NSManaged public var vacationDays: Int16
    @NSManaged public var sales: NSSet?

}

// MARK: Generated accessors for sales
extension Employee {

    @objc(addSalesObject:)
    @NSManaged public func addToSales(_ value: Sale)

    @objc(removeSalesObject:)
    @NSManaged public func removeFromSales(_ value: Sale)

    @objc(addSales:)
    @NSManaged public func addToSales(_ values: NSSet)

    @objc(removeSales:)
    @NSManaged public func removeFromSales(_ values: NSSet)

}
