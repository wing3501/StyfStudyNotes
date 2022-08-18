//
//  CamperServiceTests.swift
//  StyfStudyNotesTests
//
//  Created by styf on 2022/8/18.
//

import XCTest
import StyfStudyNotes
import CoreData

final class CamperServiceTests: XCTestCase {

    var camperService: CamperService!
    var coreDataStack: CampgroundCoreDataStack!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of+ each test method in the class.
        
        coreDataStack = TestCoreDataStack()
        camperService = CamperService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        camperService = nil
        coreDataStack = nil
    }
    
    func testAddCamper() {
        let camper = camperService.addCamper("Bacon Lover",phoneNumber: "910-543-9000")
        XCTAssertNotNil(camper, "Camper should not be nil")
        XCTAssertTrue(camper?.fullName == "Bacon Lover")
        XCTAssertTrue(camper?.phoneNumber == "910-543-9000")
    }
    
    func testRootContextIsSavedAfterAddingCamper() {
//        let expectation = expectation(withDescription: "Done!")
//        someService.callMethodWithCompletionHandler() {
//          expectation.fulfill()
//        }
//        waitForExpectations(timeout: 2.0, handler: nil)
        
        //1 改用后台上下文
        let derivedContext = coreDataStack.newDerivedContext()
        camperService = CamperService(managedObjectContext: derivedContext,coreDataStack: coreDataStack)
        //2
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.mainContext) { notification in
            return true
        }
        //3
        derivedContext.perform {
            let camper = self.camperService.addCamper("Bacon Lover", phoneNumber: "910-543-9000")
            XCTAssertNotNil(camper)
        }
        //4
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
