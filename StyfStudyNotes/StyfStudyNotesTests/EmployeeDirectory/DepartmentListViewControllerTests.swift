//
//  DepartmentListViewControllerTests.swift
//  StyfStudyNotesTests
//
//  Created by styf on 2022/8/22.
//

import XCTest
@testable import StyfStudyNotes

final class DepartmentListViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testTotalEmployeesPerDepartment() {
      measureMetrics([.wallClockTime],
                     automaticallyStartMeasuring: false) {
        let departmentList = DepartmentListViewController()
        departmentList.coreDataStack = CoreDataStack(modelName: "EmployeeDirectory")
        startMeasuring()
        _ = departmentList.totalEmployeesPerDepartment()
        stopMeasuring()
    } }

    func testTotalEmployeesPerDepartmentFast() {
      measureMetrics([.wallClockTime],
                     automaticallyStartMeasuring: false) {
        let departmentList = DepartmentListViewController()
        departmentList.coreDataStack =
          CoreDataStack(modelName: "EmployeeDirectory")
          startMeasuring()
              _ = departmentList.totalEmployeesPerDepartmentFast()
              stopMeasuring()
          } }

}
