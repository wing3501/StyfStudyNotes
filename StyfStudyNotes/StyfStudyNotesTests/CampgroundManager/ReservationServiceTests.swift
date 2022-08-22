//
//  ReservationServiceTests.swift
//  StyfStudyNotesTests
//
//  Created by styf on 2022/8/18.
//

import XCTest
import StyfStudyNotes

final class ReservationServiceTests: XCTestCase {

    // MARK: Properties
    var campSiteService: CampSiteService!
    var camperService: CamperService!
    var reservationService: ReservationService!
    var coreDataStack: CampgroundCoreDataStack!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        coreDataStack = TestCoreDataStack()
        camperService = CamperService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        campSiteService = CampSiteService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        reservationService = ReservationService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        camperService = nil
        campSiteService = nil
        reservationService = nil
        coreDataStack = nil
    }

    func testReserveCampSitePositiveNumberOfDays() {
        let camper = camperService.addCamper("Johnny Appleseed", phoneNumber: "408-555-1234")!
        let campSite = campSiteService.addCampSite(15, electricity: false, water: false)
        let result = reservationService.reserveCampSite(campSite, camper: camper, date: Date(), numberOfNights: 5)
        XCTAssertNotNil(result.reservation, "Reservation should not be nil")
        XCTAssertNil(result.error, "No error should be present")
        XCTAssertTrue(result.reservation?.status == "Reserved", "Status should be Reserved")
    }
    
    func testReserveCampSiteNegativeNumberOfDays() {
        let camper = camperService.addCamper("Johnny Appleseed", phoneNumber: "408-555-1234")!
        let campSite = campSiteService.addCampSite(15, electricity: false, water: false)
        let result = reservationService!.reserveCampSite(campSite, camper: camper, date: Date(), numberOfNights: -1)
        XCTAssertNotNil(result.reservation,"Reservation should not be nil")
        XCTAssertNotNil(result.error, "An error should be present")
        XCTAssertTrue(result.error?.userInfo["Problem"] as? String == "Invalid number of days", "Error problem should be present")
        XCTAssertTrue(result.reservation?.status == "Invalid", "Status should be Invalid")
    }
}
