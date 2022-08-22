//
//  DepartmentListViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/18.
//

import UIKit
import CoreData

class DepartmentListViewController: UIViewController {

    var coreDataStack: CoreDataStack!
    var items: [[String: String]] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        let cellNib = UINib(nibName: "DepartmentTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "DepartmentCellReuseIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(tableView)
        items = totalEmployeesPerDepartmentFast()
    }
    
}

// MARK: Internal
extension DepartmentListViewController {

  func totalEmployeesPerDepartment() -> [[String: String]] {

      // 1 抓取所有员工
      let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()

      var fetchResults: [Employee] = []
      do {
          fetchResults = try coreDataStack.mainContext.fetch(fetchRequest)
      } catch let error as NSError {
          print("ERROR: \(error.localizedDescription)")
          return [[String: String]]()
      }

      // 2 统计各部门人数
      var uniqueDepartments: [String: Int] = [:]
      for employee in fetchResults where employee.department != nil {
          uniqueDepartments[employee.department!, default: 0] += 1
      }

      // 3 整理数据到数组
      return uniqueDepartments.map { (department, headCount) in
          ["department": department,
           "headCount": String(headCount)]
      }
    }
    
    // 优化版本✅
    func totalEmployeesPerDepartmentFast() -> [[String: String]] {
      //1
      let expressionDescription = NSExpressionDescription()
      expressionDescription.name = "headCount"
    //2
      let arguments = [NSExpression(forKeyPath: #keyPath(Employee.department))]//"department"
      expressionDescription.expression = NSExpression(forFunction: "count:", arguments: arguments)
    //3
      let fetchRequest: NSFetchRequest<NSDictionary> = NSFetchRequest(entityName: "Employee")
      fetchRequest.propertiesToFetch = ["department", expressionDescription] //只抓取最少的属性
      fetchRequest.propertiesToGroupBy = ["department"] //按属性分组
      fetchRequest.resultType = .dictionaryResultType
    //4
      var fetchResults: [NSDictionary] = []
      do {
        fetchResults =
          try coreDataStack.mainContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("ERROR: \(error.localizedDescription)")
        return [[String: String]]()
      }
      return fetchResults as! [[String: String]]
    }
}

// MARK: UITableViewDataSource
extension DepartmentListViewController: UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let departmentDictionary: [String: String] = items[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartmentCellReuseIdentifier",
                                             for: indexPath)
        
        cell.textLabel?.text = departmentDictionary["department"]
        cell.detailTextLabel?.text = departmentDictionary["headCount"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let departmentDictionary = items[indexPath.row]
        let department = departmentDictionary["department"]
        let controller = EmployeeListViewController()
        controller.coreDataStack = coreDataStack
        controller.department = department
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let departmentDictionary = items[indexPath.row]
        let department = departmentDictionary["department"]
        let controller = DepartmentDetailsViewController(nibName: nil, bundle: nil)
        controller.coreDataStack = coreDataStack
        controller.department = department
        navigationController?.pushViewController(controller, animated: true)
    }
}

