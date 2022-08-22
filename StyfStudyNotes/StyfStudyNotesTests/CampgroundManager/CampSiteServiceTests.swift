//
//  CampSiteServiceTests.swift
//  StyfStudyNotesTests
//
//  Created by styf on 2022/8/18.
//

import XCTest
import StyfStudyNotes

final class CampSiteServiceTests: XCTestCase {

    // MARK: Properties
    var campSiteService: CampSiteService!
    var coreDataStack: CampgroundCoreDataStack!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataStack = TestCoreDataStack()
        campSiteService = CampSiteService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        campSiteService = nil
        coreDataStack = nil
    }
    
    func testAddCampSite() {
        let campSite = campSiteService.addCampSite(1,electricity: true,water: true)
        XCTAssertTrue(campSite.siteNumber == 1, "Site number should be 1")
        XCTAssertTrue(campSite.electricity, "Site should have electricity")
        XCTAssertTrue(campSite.water, "Site should have water")
    }
    
    func testRootContextIsSavedAfterAddingCampsite() {
        let derivedContext = coreDataStack.newDerivedContext()
        campSiteService = CampSiteService(managedObjectContext: derivedContext, coreDataStack: coreDataStack)
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.mainContext) { notification in
            return true
        }
      
        derivedContext.perform {
            let campSite = self.campSiteService.addCampSite(1,electricity: true,water: true)
            XCTAssertNotNil(campSite)
        }
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
          
    func testGetCampSiteWithMatchingSiteNumber() {
        _ = campSiteService.addCampSite(1,electricity: true,water: true)
        let campSite = campSiteService.getCampSite(1)
        XCTAssertNotNil(campSite, "A campsite should be returned")
    }
    
    func testGetCampSiteNoMatchingSiteNumber() {
        _ = campSiteService.addCampSite(1,electricity: true,water: true)
        let campSite = campSiteService.getCampSite(2)
        XCTAssertNil(campSite, "No campsite should be returned")
    }

}
