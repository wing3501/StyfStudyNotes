//
//  EmployeeListViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/18.
//

import UIKit
import CoreData

class EmployeeListViewController: UIViewController {

    var coreDataStack: CoreDataStack!
    
    var fetchedResultController: NSFetchedResultsController<Employee> = NSFetchedResultsController()
    
    var department: String?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        let cellNib = UINib(nibName: "EmployeeTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "EmployeeCellReuseIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        configureView()
    }
}

private extension EmployeeListViewController {

    func configureView() {
        fetchedResultController = employeesFetchedResultControllerFor(department)
    }
}

extension EmployeeListViewController {
    
    func employeesFetchedResultControllerFor(_ department: String?) -> NSFetchedResultsController<Employee> {

        fetchedResultController = NSFetchedResultsController(fetchRequest: employeeFetchRequest(department), managedObjectContext: coreDataStack.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self

        do {
            try fetchedResultController.performFetch()
            return fetchedResultController
        } catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func employeeFetchRequest(_ department: String?) -> NSFetchRequest<Employee> {

        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()

        let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        guard let department = department else {
            return fetchRequest
        }

        fetchRequest.predicate = NSPredicate(format: "%K = %@",argumentArray: [#keyPath(Employee.department),department])

        return fetchRequest
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension EmployeeListViewController: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

extension EmployeeListViewController: UITableViewDataSource,UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
      return fetchedResultController.sections!.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return fetchedResultController.sections![section].numberOfObjects
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let reuseIdentifier = "EmployeeCellReuseIdentifier"

    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                             for: indexPath) as! EmployeeTableViewCell

    let employee = fetchedResultController.object(at: indexPath)

    cell.nameLabel.text = employee.name
    cell.departmentLabel.text = employee.department
    cell.emailLabel.text = employee.email
    cell.phoneNumberLabel.text = employee.phone
    cell.pictureImageView.image = UIImage(data: employee.picture!)

    return cell
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EmployeeDetailViewController(nibName: nil, bundle: nil)
        let selectedEmployee = fetchedResultController.object(at: indexPath)
        vc.employee = selectedEmployee
        navigationController?.pushViewController(vc, animated: true)
    }
}
