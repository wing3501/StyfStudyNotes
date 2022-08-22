//
//  SurfJournal.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/22.
//

import UIKit
import CoreData

// 一般需要多个上下文的场景
// 1 阻塞主线程的场景比如数据导出
// 2 可能需要放弃修改，比如修改用户信息

class SurfJournal: UIViewController {
    
    // MARK: Properties
    var coreDataStack: SurfCoreDataStack = SurfCoreDataStack(modelName: "SurfJournalModel")
    var fetchedResultsController: NSFetchedResultsController<JournalEntry> = NSFetchedResultsController()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        let cellNib = UINib(nibName: "SurfEntryTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// MARK: Private
private extension SurfJournal {
    func configureView() {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        navigationItem.leftBarButtonItem = exportBarButtonItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(add(_:)))
        
        fetchedResultsController = journalListFetchedResultsController()
    }
    
    @objc private func exportButtonTapped(_ sender: UIBarButtonItem) {
        exportCSVFile()
    }
    
    @objc private func add(_ sender: UIBarButtonItem) {
        let vc = JournalEntryViewController()
        let newJournalEntry = JournalEntry(context: coreDataStack.mainContext)

        vc.journalEntry = newJournalEntry
        vc.context = newJournalEntry.managedObjectContext
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func exportCSVFile() {
      navigationItem.leftBarButtonItem = activityIndicatorBarButtonItem()

      // 1
      let context = coreDataStack.mainContext
      var results: [JournalEntry] = []
      do {
        results = try context.fetch(self.surfJournalFetchRequest())
      } catch let error as NSError {
        print("ERROR: \(error.localizedDescription)")
      }

      // 2
      let exportFilePath = NSTemporaryDirectory() + "export.csv"
      let exportFileURL = URL(fileURLWithPath: exportFilePath)
      FileManager.default.createFile(atPath: exportFilePath, contents: Data(), attributes: nil)

      // 3
      let fileHandle: FileHandle?
      do {
        fileHandle = try FileHandle(forWritingTo: exportFileURL)
      } catch let error as NSError {
        print("ERROR: \(error.localizedDescription)")
        fileHandle = nil
      }

      if let fileHandle = fileHandle {
        // 4
        for journalEntry in results {
          fileHandle.seekToEndOfFile()
          guard let csvData = journalEntry
            .csv()
            .data(using: .utf8, allowLossyConversion: false) else {
              continue
          }

          fileHandle.write(csvData)
        }

        // 5
        fileHandle.closeFile()

        print("Export Path: \(exportFilePath)")
        self.navigationItem.leftBarButtonItem = self.exportBarButtonItem()
        self.showExportFinishedAlertView(exportFilePath)

      } else {
        self.navigationItem.leftBarButtonItem = self.exportBarButtonItem()
      }
    }
    
    // MARK: Export
    
    func activityIndicatorBarButtonItem() -> UIBarButtonItem {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        let barButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
      
        return barButtonItem
    }
    
    func exportBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: "Export", style: .plain, target: self, action: #selector(exportButtonTapped(_:)))
    }
    
    func showExportFinishedAlertView(_ exportPath: String) {
        let message = "The exported CSV file can be found at \(exportPath)"
        let alertController = UIAlertController(title: "Export Finished", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
        alertController.addAction(dismissAction)

        present(alertController, animated: true)
    }
}

// MARK: NSFetchedResultsController
private extension SurfJournal {
    func journalListFetchedResultsController() -> NSFetchedResultsController<JournalEntry> {
        let fetchedResultController = NSFetchedResultsController(fetchRequest: surfJournalFetchRequest(),
                                                                 managedObjectContext: coreDataStack.mainContext,
                                                                 sectionNameKeyPath: nil,
                                                                 cacheName: nil)
        fetchedResultController.delegate = self

        do {
            try fetchedResultController.performFetch()
        } catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
        }

        return fetchedResultController
    }
    
    func surfJournalFetchRequest() -> NSFetchRequest<JournalEntry> {
        let fetchRequest:NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        fetchRequest.fetchBatchSize = 20

        let sortDescriptor = NSSortDescriptor(key: #keyPath(JournalEntry.date), ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        return fetchRequest
    }
}

// MARK: NSFetchedResultsControllerDelegate
extension SurfJournal: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

extension SurfJournal: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SurfEntryTableViewCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    private func configureCell(_ cell: SurfEntryTableViewCell, indexPath: IndexPath) {
      let surfJournalEntry = fetchedResultsController.object(at: indexPath)
      cell.dateLabel.text = surfJournalEntry.stringForDate()
        
//      guard let rating = surfJournalEntry.rating?.int32Value else { return }

      switch surfJournalEntry.rating {
      case 1:
        cell.starOneFilledImageView.isHidden = false
        cell.starTwoFilledImageView.isHidden = true
        cell.starThreeFilledImageView.isHidden = true
        cell.starFourFilledImageView.isHidden = true
        cell.starFiveFilledImageView.isHidden = true
      case 2:
        cell.starOneFilledImageView.isHidden = false
        cell.starTwoFilledImageView.isHidden = false
        cell.starThreeFilledImageView.isHidden = true
        cell.starFourFilledImageView.isHidden = true
        cell.starFiveFilledImageView.isHidden = true
      case 3:
        cell.starOneFilledImageView.isHidden = false
        cell.starTwoFilledImageView.isHidden = false
        cell.starThreeFilledImageView.isHidden = false
        cell.starFourFilledImageView.isHidden = true
        cell.starFiveFilledImageView.isHidden = true
      case 4:
        cell.starOneFilledImageView.isHidden = false
        cell.starTwoFilledImageView.isHidden = false
        cell.starThreeFilledImageView.isHidden = false
        cell.starFourFilledImageView.isHidden = false
        cell.starFiveFilledImageView.isHidden = true
      case 5:
        cell.starOneFilledImageView.isHidden = false
        cell.starTwoFilledImageView.isHidden = false
        cell.starThreeFilledImageView.isHidden = false
        cell.starFourFilledImageView.isHidden = false
        cell.starFiveFilledImageView.isHidden = false
      default:
        cell.starOneFilledImageView.isHidden = true
        cell.starTwoFilledImageView.isHidden = true
        cell.starThreeFilledImageView.isHidden = true
        cell.starFourFilledImageView.isHidden = true
        cell.starFiveFilledImageView.isHidden = true
      }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard case(.delete) = editingStyle else { return }
        
        let surfJournalEntry = fetchedResultsController.object(at: indexPath)
        coreDataStack.mainContext.delete(surfJournalEntry)
        coreDataStack.saveContext()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = JournalEntryViewController()
        let surfJournalEntry = fetchedResultsController.object(at: indexPath)

        vc.journalEntry = surfJournalEntry
        vc.context = surfJournalEntry.managedObjectContext
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: JournalEntryDelegate
extension SurfJournal: JournalEntryDelegate {
    func didFinish(viewController: JournalEntryViewController, didSave: Bool) {

      guard didSave,
        let context = viewController.context,
        context.hasChanges else {
          navigationController?.popViewController(animated: true)
          return
      }

      context.perform {
        do {
          try context.save()
        } catch let error as NSError {
          fatalError("Error: \(error.localizedDescription)")
        }

        self.coreDataStack.saveContext()
      }

        navigationController?.popViewController(animated: true)
    }
}
