//
//  DogWalk.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/11.
//

import UIKit
import CoreData

class DogWalk: UIViewController {

    // MARK: - Properties
    lazy var dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .short
      formatter.timeStyle = .medium
      return formatter
    }()

    var currentDog: Dog?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var coreDataStack = CoreDataStack(modelName: "Dog Walk")
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedContext = coreDataStack.managedContext
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(add(_:)))
        view.addSubview(tableView)
        
        let dogName = "Fido"
        let dogFetch: NSFetchRequest<Dog> = Dog.fetchRequest()
        dogFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Dog.name),dogName)
        do {
            let resutls = try managedContext.fetch(dogFetch)
            if resutls.count > 0 {
                currentDog = resutls.first
            } else {
                currentDog = Dog(context: managedContext)
                currentDog?.name = dogName
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    @objc public func add(_ sender: UIBarButtonItem) {
        let walk = Walk(context: managedContext)
        walk.date = Date()
        
//        if let dog = currentDog,
//            let walks = dog.walks?.mutableCopy()
//                          as? NSMutableOrderedSet {
//            walks.add(walk)
//            dog.walks = walks
//        }
        
        currentDog?.addToWalks(walk)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Save error: \(error),description: \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
}

extension DogWalk: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentDog?.walks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let walk = currentDog?.walks?[indexPath.row] as? Walk,
            let walkDate = walk.date as Date? else { return cell }
        cell.textLabel?.text = dateFormatter.string(from: walkDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Walks"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let walkToRemove = currentDog?.walks?[indexPath.row] as? Walk,editingStyle == .delete else { return }
        //删除
        managedContext.delete(walkToRemove)
        do {
            try managedContext.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print("Save error: \(error),description: \(error.userInfo)")
        }
    }
}

