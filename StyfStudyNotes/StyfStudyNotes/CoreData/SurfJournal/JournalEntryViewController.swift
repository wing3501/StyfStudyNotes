//
//  JournalEntryViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/22.
//

import UIKit
import CoreData

// MARK: JournalEntryDelegate
protocol JournalEntryDelegate {
  func didFinish(viewController: JournalEntryViewController, didSave: Bool)
}

class JournalEntryViewController: UIViewController {
    
    // MARK: Properties
    var journalEntry: JournalEntry?
    var context: NSManagedObjectContext!
    var delegate:JournalEntryDelegate?
    
    var heightTextField: UITextField?
    var periodTextField: UITextField?
    var windTextField: UITextField?
    var locationTextField: UITextField?
    var ratingSegmentedControl: UISegmentedControl?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        let cellNib1 = UINib(nibName: "SurfTextFieldCell", bundle: nil)
        let cellNib2 = UINib(nibName: "SurfSegmentCell", bundle: nil)
        tableView.register(cellNib1, forCellReuseIdentifier: "SurfTextFieldCell")
        tableView.register(cellNib2, forCellReuseIdentifier: "SurfSegmentCell")
        tableView.dataSource = self
        tableView.rowHeight = 44
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelButtonWasTapped(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveButtonWasTapped(_:)))
        
        guard let journalEntry = journalEntry else { return }

        title = journalEntry.stringForDate()
    }
    
    func updateJournalEntry() {
        guard let entry = journalEntry else { return }

        entry.date = Date()
        entry.height = heightTextField!.text
        entry.period = periodTextField!.text
        entry.wind = windTextField!.text
        entry.location = locationTextField!.text
        entry.rating = Int16(ratingSegmentedControl!.selectedSegmentIndex + 1)
    }
    
    @objc private func cancelButtonWasTapped(_ sender: UIBarButtonItem) {
        delegate?.didFinish(viewController: self, didSave: false)
    }
    @objc private func saveButtonWasTapped(_ sender: UIBarButtonItem) {
        updateJournalEntry()
        delegate?.didFinish(viewController: self, didSave: true)
    }
}

extension JournalEntryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurfTextFieldCell", for: indexPath) as! SurfTextFieldCell
            cell.label.text = ["Height:","Period:","Wind:","Location:"][indexPath.row]
            cell.textField.text = [journalEntry?.height,journalEntry?.period,journalEntry?.wind,journalEntry?.location][indexPath.row]
            switch indexPath.row {
            case 0:
                heightTextField = cell.textField
            case 1:
                periodTextField = cell.textField
            case 2:
                windTextField = cell.textField
            case 3:
                locationTextField = cell.textField
            default:
                break
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurfSegmentCell", for: indexPath) as! SurfSegmentCell
            if let rating = journalEntry?.rating {
                cell.segment.selectedSegmentIndex = Int(rating - 1)
                ratingSegmentedControl = cell.segment
            }
            return cell
        }
    }
}
