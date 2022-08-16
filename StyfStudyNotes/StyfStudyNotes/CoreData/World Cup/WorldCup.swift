//
//  WorldCup.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/15.
//

import UIKit
import CoreData

// ☀️总结
// 1.NSFetchedResultsController用于Core Data与TableView同步数据
// 2.NSFetchedResultsController的本质是NSFetchRequest和抓取结果集的封装
// 3.NSFetchedResultsController需要设置至少一个排序描述符
// 4.设置sectionNameKeyPath实现数据分组功能
// 5.设置cache name去实现分组缓存
// 6.NSFetchedResultsControllerDelegate用于监听数据变化
// 7.NSFetchedResultsControllerDelegate可以监听单个数据或者整个setion的变化

class WorldCup: UIViewController {

    fileprivate let teamCellIdentifier = "teamCellReuseIdentifier"
    
    lazy var coreDataStack = CoreDataStack(modelName: "WorldCup")
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        let cellNib = UINib(nibName: "TeamCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: teamCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 88
        return tableView
    }()
    // ✅ NSFetchedResultsController的使用
    // NSFetchedResultsController的本质是NSFetchRequest和抓取结果集的封装，协调Core Data与TableView
    // 通过fetchedObjects和object(at:)获取结果
    lazy var fetchedResultsController: NSFetchedResultsController<Team> = {
        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        // ⚠️不可省略排序描述符  NSFetchedResultsController要求至少一个排序描述符
//        let sort = NSSortDescriptor(key: #keyPath(Team.teamName),ascending: true)
//        fetchRequest.sortDescriptors = [sort]
        // ⚠️解决因按名称字母排序分组导致分组错误的问题 （如果需要分组，那么第一个排序描述符必须就是分组的属性）
        let zoneSort = NSSortDescriptor(key: #keyPath(Team.qualifyingZone), ascending: true)
        let scoreSort = NSSortDescriptor(key: #keyPath(Team.wins), ascending: false)
        let nameSort = NSSortDescriptor(key: #keyPath(Team.teamName), ascending: true)
        fetchRequest.sortDescriptors = [zoneSort, scoreSort, nameSort]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: #keyPath(Team.qualifyingZone), cacheName: "worldCup")//✅ 使用属性进行数据分区，支持keypath,比如 employee.address.street
        //✅ 使用分区缓存，只需要指定缓存名称cacheName
        // 任何改动（比如排序描述符、entry描述改动）会引起缓存无效，需要删除缓存 deleteCache(withName:)
        
        //✅ NSFetchedResultsController只能监听通过初始化器中指定的managedObjectContext改变数据的变化，通过别的上下文改变数据，代理不会有回调
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        importJSONSeedDataIfNeeded()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(add(_:)))
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("摇一摇")
        }
    }
    
    @objc public func add(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Secret Team",message: "Add a new team",preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Team Name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Qualifying Zone"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let nameTextField = alertController.textFields?.first,
                  let zoneTextField = alertController.textFields?.last else {
                return
            }
            let team = Team(context: self.coreDataStack.managedContext)
            team.teamName = nameTextField.text
            team.qualifyingZone = zoneTextField.text
            team.imageName = "wenderland-flag"
            self.coreDataStack.saveContext()
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
}

extension WorldCup {
    func configure(cell: UITableViewCell, for indexPath: IndexPath) {
        guard let cell = cell as? TeamCell else {
            return
        }
        let team = fetchedResultsController.object(at: indexPath)
        cell.teamLabel.text = team.teamName
        cell.scoreLabel.text = "Wins: \(team.wins)"
        
        if let imageName = team.imageName {
            cell.flagImageView.image = UIImage(named: imageName)
        } else {
            cell.flagImageView.image = nil
        }
    }
}

extension WorldCup: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else {
            return 0
        }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teamCellIdentifier, for: indexPath)
        configure(cell: cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = fetchedResultsController.sections?[section]
        return sectionInfo?.name
    }
}

extension WorldCup: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = fetchedResultsController.object(at: indexPath)
        team.wins = team.wins + 1
        coreDataStack.saveContext()
//        tableView.reloadData() //这一行可以删除了，通过数据监听还更新
    }
}

extension WorldCup: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            let cell = tableView.cellForRow(at: indexPath!) as! TeamCell
            configure(cell: cell, for: indexPath!)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.reloadData() //进一步优化效果
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        // 这个代理方法有点类似于controllerDidChangeContent。不同的是整个section创建或删除时回调
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default:
            break
        }
    }
}

extension WorldCup {
    func importJSONSeedDataIfNeeded() {

        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        let count = try? coreDataStack.managedContext.count(for: fetchRequest)

        guard let teamCount = count,teamCount == 0 else {
          return
        }

        importJSONSeedData()
    }
    
    func importJSONSeedData() {

      let jsonURL = Bundle.main.url(forResource: "WorldCupSeed", withExtension: "json")!
      let jsonData = try! Data(contentsOf: jsonURL)

      do {
        let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: [.allowFragments]) as! [[String: Any]]

        for jsonDictionary in jsonArray {
          let teamName = jsonDictionary["teamName"] as! String
          let zone = jsonDictionary["qualifyingZone"] as! String
          let imageName = jsonDictionary["imageName"] as! String
          let wins = jsonDictionary["wins"] as! NSNumber

          let team = Team(context: coreDataStack.managedContext)
          team.teamName = teamName
          team.imageName = imageName
          team.qualifyingZone = zone
          team.wins = wins.int32Value
        }

        coreDataStack.saveContext()
        print("Imported \(jsonArray.count) teams")

      } catch let error as NSError {
        print("Error importing teams: \(error)")
      }
    }
}
