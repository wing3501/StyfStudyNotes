//
//  EmployeePictureViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/19.
//

import UIKit

class EmployeePictureViewController: UIViewController {

    // MARK: - Properties
    var employee: Employee?
    
    @IBOutlet weak var employeePictureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeePictureImageView.isUserInteractionEnabled = true
        employeePictureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        configureView()
    }

    @objc func tap() {
        dismiss(animated: true)
    }
}


private extension EmployeePictureViewController {

  func configureView() {
    guard let employeePicture = employee?.picture else {
      return
    }

    employeePictureImageView.image = UIImage(data: employeePicture)
  }
}
