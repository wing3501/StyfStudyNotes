//
//  EmployeePicture+CoreDataProperties.swift
//  
//
//  Created by styf on 2022/8/22.
//
//

import Foundation
import CoreData


extension EmployeePicture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeePicture> {
        return NSFetchRequest<EmployeePicture>(entityName: "EmployeePicture")
    }

    @NSManaged public var picture: Data?
    @NSManaged public var employee: Employee?

}
