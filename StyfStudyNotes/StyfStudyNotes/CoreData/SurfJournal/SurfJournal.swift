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
    // 传统的优化方法可能是使用GCD把导出操作扔到后台队列，但是托管对象上下文不是线程安全的，所以不能仅仅是用同一个Core Data堆栈，派发的后台线程
// 2 可能需要放弃修改，比如修改用户信息
    // 每个上下文有一个父存储，用于检索、修改数据。通常这个父存储是persistent store coordinator。
    // 但是也可以设置父存储为其他上下文，成为它的子上下文
    // 保存子上下文时，修改会同步到父上下文。保存父上下文时才会发送到persistent store coordinator。

// 优化
// 1. 使用coreDataStack.storeContainer.performBackgroundTask，用后台上下文来处理阻塞主线程的操作
// 2. 使用子上下文来优化编辑。解决取消新增的记录仍然存在的问题。

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
//        exportCSVFile()
        exportCSVFileAsync()
    }
    
    @objc private func add(_ sender: UIBarButtonItem) {
        let vc = JournalEntryViewController()
//        let newJournalEntry = JournalEntry(context: coreDataStack.mainContext)
//
//        vc.journalEntry = newJournalEntry
//        vc.context = newJournalEntry.managedObjectContext
//        vc.delegate = self
        
        // ✅ 修改为使用子上下文
        // 1 创建一个子上下文
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = coreDataStack.mainContext
        // 2
        let childEntry = JournalEntry(context: childContext)
        // 3 设置参数
        vc.journalEntry = childEntry
        vc.context = childContext
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    //✅ 优化为后台抓取
    func exportCSVFileAsync() {
        navigationItem.leftBarButtonItem = activityIndicatorBarButtonItem()
          // performBackgroundTask会创建一个新的上下文，传到闭包
          // performBackgroundTask在一个私有队列上，不会阻塞主线程
          coreDataStack.storeContainer.performBackgroundTask { context in
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
                  
                  DispatchQueue.main.async {
                      self.navigationItem.leftBarButtonItem = self.exportBarButtonItem()
                      self.showExportFinishedAlertView(exportFilePath)
                  }
              } else {
                  DispatchQueue.main.async {
                      self.navigationItem.leftBarButtonItem = self.exportBarButtonItem()
                  }
              }
              
              
          }
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

//        vc.journalEntry = surfJournalEntry
//        vc.context = surfJournalEntry.managedObjectContext
//        vc.delegate = self
        
        // ✅ 修改为使用子上下文
        // 1 创建一个子上下文
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = coreDataStack.mainContext
        // 2 ⚠️用id在检索出在子上下文中的对象。 因为托管对象在创建它的上下文中是特定的，但是对象Id是唯一的
        let childEntry = childContext.object(with: surfJournalEntry.objectID) as? JournalEntry
        // 3 设置参数
        vc.journalEntry = childEntry
        vc.context = childContext
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
        //如果一个上下文的类型是MainQueueConcurrencyType，则不必使用perform来包起来
        // 如果我们不知道这个上下文是什么类型，那最好还是用perform包一下，可以同时支持父、子上下文
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
