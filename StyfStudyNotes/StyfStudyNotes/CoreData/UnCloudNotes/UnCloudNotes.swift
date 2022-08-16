//
//  UnCloudNotes.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/16.
//

import UIKit
import CoreData

class UnCloudNotes: UIViewController {

    fileprivate lazy var stack: NoteCoreDataStack = NoteCoreDataStack(modelName: "UnCloudNotesDataModel")
    
    fileprivate lazy var notes: NSFetchedResultsController<Note> = {
      let context = self.stack.managedContext
      let request = Note.fetchRequest() as! NSFetchRequest<Note>
      request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Note.dateCreated), ascending: false)]

      let notes = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
      notes.delegate = self
      return notes
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        tableView.dataSource = self
        tableView.rowHeight = 70
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(add(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            try notes.performFetch()
        } catch {
            print("Error: \(error)")
        }
        tableView.reloadData()
    }
    
    @objc public func add(_ sender: UIBarButtonItem) {
        let createVC = CreateNoteViewController(nibName: "CreateNoteViewController", bundle: nil)
        createVC.managedObjectContext = stack.savingContext
        createVC.finishBlock = { [self] in
            stack.saveContext()
        }
        navigationController?.pushViewController(createVC, animated: true)
    }
}

extension UnCloudNotes: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let objects = notes.fetchedObjects
        return objects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        cell.note = notes.object(at: indexPath)
        return cell
    }
}

extension UnCloudNotes: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        let wrapIndexPath: (IndexPath?) -> [IndexPath] = { $0.map { [$0] } ?? [] }
        switch type {
        case .insert:
           tableView.insertRows(at: wrapIndexPath(newIndexPath), with: .automatic)
        case .delete:
           tableView.deleteRows(at: wrapIndexPath(indexPath), with: .automatic)
        default:
           break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
}
