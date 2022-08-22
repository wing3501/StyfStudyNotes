//
//  EmployeeDetailViewControllerTests.swift
//  StyfStudyNotesTests
//
//  Created by styf on 2022/8/22.
//

import XCTest
import CoreData
@testable import StyfStudyNotes

final class EmployeeDetailViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCountSales() {
      measureMetrics([.wallClockTime],
                     automaticallyStartMeasuring: false) {
                      
                      let employee = getEmployee()
                      let employeeDetails = EmployeeDetailViewController()
                      startMeasuring()
                      _ = employeeDetails.salesCountForEmployee(employee)
                      stopMeasuring()
      }
    }

    func testCountSalesFast() {
      measureMetrics([.wallClockTime],
                     automaticallyStartMeasuring: false) {
        let employee = getEmployee()
        let employeeDetails = EmployeeDetailViewController()
        startMeasuring()
        _ = employeeDetails.salesCountForEmployeeFast(employee)
        stopMeasuring()
    } }
    
    
    func testCountSalesSimple() {
      measureMetrics([.wallClockTime],
                     automaticallyStartMeasuring: false) {
                      let employee = getEmployee()
                      let employeeDetails = EmployeeDetailViewController()
                      startMeasuring()
                      _ = employeeDetails.salesCountForEmployeeSimple(employee)
                      stopMeasuring()
      }
    }
    
    func getEmployee() -> Employee {
      let coreDataStack = CoreDataStack(modelName: "EmployeeDirectory")
      
      let request: NSFetchRequest<Employee> = Employee.fetchRequest()
      
      request.sortDescriptors = [NSSortDescriptor(key: "guid", ascending: true)]
      request.fetchBatchSize = 1
      let results: [AnyObject]?
      do {
        results = try coreDataStack.mainContext.fetch(request)
      } catch _ {
        results = nil
      }
      return results![0] as! Employee
    }
}
