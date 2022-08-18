//
//  CampSiteService.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/18.
//

import Foundation
import CoreData

public final class CampSiteService {

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
extension CampSiteService {

    public func addCampSite(_ siteNumber: NSNumber, electricity: Bool, water: Bool) -> CampSite {
        let campSite = CampSite(context: managedObjectContext)
        campSite.siteNumber = siteNumber.int16Value
        campSite.electricity = electricity
        campSite.water = water

        coreDataStack.saveContext(managedObjectContext)

        return campSite
    }

    public func deleteCampSite(_ siteNumber: NSNumber) {
        // TODO : Not yet implemented
    }

    public func getCampSite(_ siteNumber: NSNumber) -> CampSite? {
        let fetchRequest: NSFetchRequest<CampSite> = CampSite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(CampSite.siteNumber), siteNumber])
        let results: [CampSite]?
        do {
            results = try managedObjectContext.fetch(fetchRequest)
        } catch {
            return nil
        }

        return results?.first
  }

    public func getCampSites() -> [CampSite] {
        // TODO : Not yet implemented

        return []
    }

    public func getNextCampSiteNumber() -> NSNumber {
        // TODO : Not yet implemented

        return -1
    }
}
