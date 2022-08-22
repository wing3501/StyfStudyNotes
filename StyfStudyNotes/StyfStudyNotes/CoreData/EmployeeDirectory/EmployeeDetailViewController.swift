//
//  EmployeeDetailViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/19.
//

import UIKit
import CoreData

class EmployeeDetailViewController: UIViewController {

    // MARK: - Properties
    fileprivate lazy var dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      return formatter
    }()

    var employee: Employee?
    
    @IBOutlet weak var headShotImageView: UIImageView!
    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var vacationDaysLabel: UILabel!
    @IBOutlet weak var salesCountLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        headShotImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    @objc func tap() {
        let vc = EmployeePictureViewController(nibName: nil, bundle: nil)
        vc.employee = employee
        present(vc, animated: true)
    }
}

// MARK: Private
private extension EmployeeDetailViewController {

  func configureView() {
    guard let employee = employee else { return }

    title = employee.name

    let image = UIImage(data: employee.pictureThumbnail!)
    headShotImageView.image = image

    nameLabel.text = employee.name
    departmentLabel.text = employee.department
    emailLabel.text = employee.email
    phoneNumberLabel.text = employee.phone

    startDateLabel.text = dateFormatter.string(from: employee.startDate!)

      vacationDaysLabel.text = employee.vacationDays.description

    bioTextView.text = employee.about

    salesCountLabel.text = salesCountForEmployee(employee)
  }
}

// MARK: Internal
extension EmployeeDetailViewController {

  func salesCountForEmployee(_ employee: Employee) -> String {
    
    let fetchRequest: NSFetchRequest<Sale> = Sale.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "%K = %@",
                                         argumentArray: [#keyPath(Sale.employee),
                                                         employee])

    let context = employee.managedObjectContext!
    do {
      let results = try context.fetch(fetchRequest)
      return "\(results.count)"
    } catch let error as NSError {
      print("Error: \(error.localizedDescription)")
      return "0"
    }
  }
    // ✅使用count方法来进一步优化
    func salesCountForEmployeeFast(_ employee: Employee) -> String {
      let fetchRequest: NSFetchRequest<Sale> = Sale.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "%K = %@",argumentArray: [#keyPath(Sale.employee), employee])
      let context = employee.managedObjectContext!
      do {
        let results = try context.count(for: fetchRequest)
          return "\(results)"
         } catch let error as NSError {
           print("Error: \(error.localizedDescription)")
       return "0" }
    }
    // ✅ 更简单的办法
    func salesCountForEmployeeSimple(_ employee: Employee) -> String {
      return "\(employee.sales!.count)"
    }
}
