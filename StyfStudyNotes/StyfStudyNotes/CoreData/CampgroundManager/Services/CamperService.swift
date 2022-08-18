//
//  CamperService.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/18.
//

import Foundation
import CoreData

public final class CamperService {

    // MARK: Properties
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CampgroundCoreDataStack

    // MARK: Initializers
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CampgroundCoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

// MARK: Public
extension CamperService {

  public func addCamper(_ name: String, phoneNumber: String) -> Camper? {
      let camper = Camper(context: managedObjectContext)
      camper.fullName = name
      camper.phoneNumber = phoneNumber

      coreDataStack.saveContext(managedObjectContext)

      return camper
  }
}
