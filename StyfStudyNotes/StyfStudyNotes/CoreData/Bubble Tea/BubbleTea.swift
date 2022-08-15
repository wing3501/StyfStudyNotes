//
//  BubbleTea.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/12.
//

import UIKit
import CoreData

// ☀️总结
//  1.NSFetchRequest的泛型使用
//  2.使用Data Model Editor创建不可用的模板请求
//  3.使用NSFetchRequest的count优化数量的获取
//  4.使用sum等内置函数抓取数据
//  5.使用谓词过滤
//  6.使用排序描述
//  7.使用异步抓取请求NSAsynchronousFetchRequest
//  8.使用批量更新 NSBatchUpdateRequest、NSBatchDeleteRequest

class BubbleTea: UIViewController {
    
    class VenueCell: UITableViewCell {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    private let venueCellIdentifier = "VenueCell"
    
    lazy var coreDataStack = CoreDataStack(modelName: "Bubble Tea")
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(VenueCell.self, forCellReuseIdentifier: venueCellIdentifier)
        tableView.dataSource = self
        return tableView
    }()
    
    var fetchRequest: NSFetchRequest<Venue>?
    // 异步抓取
    var asyncFetchRequest: NSAsynchronousFetchRequest<Venue>?
    var venues: [Venue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 从Json导入数据
        importJSONSeedDataIfNeeded()
        // ✅批量更新的使用
        batchUpdate()
        
        // NSFetchRequest有一个名为resultType的属性
        // 1.managedObjectResultType 默认值
        // 2.countResultType 返回符合request的对象数量
        // 3.dictionaryResultType 用于返回不同计算的结果
        // 4.managedObjectIDResultType 返回唯一标识
        
        // 🐟什么时候应该在编辑器里创建抓取请求模板？
        // 这个请求在应用中会被反复用到
        // 缺点是不能为结果指定排序
        // ✅模板请求的使用
        // ⚠️使用模板创建的请求是不可变请求
//        guard let model = coreDataStack.managedContext.persistentStoreCoordinator?.managedObjectModel,
//        let fetchRequest = model.fetchRequestTemplate(forName: "FetchRequest") as? NSFetchRequest<Venue> else { return }
//        self.fetchRequest = fetchRequest
        
        //可变
//        fetchRequest = Venue.fetchRequest()
        
        let venueFetchRequest: NSFetchRequest<Venue> = Venue.fetchRequest()
        fetchRequest = venueFetchRequest
        // ✅异步抓取的使用
        asyncFetchRequest = NSAsynchronousFetchRequest<Venue>(fetchRequest: venueFetchRequest, completionBlock: { [unowned self] (result: NSAsynchronousFetchResult) in
            guard let venues = result.finalResult else {
                return
            }
            self.venues = venues
            self.tableView.reloadData()
        })
        
        do {
            guard let asyncFetchRequest else { return }
            try coreDataStack.managedContext.execute(asyncFetchRequest)
            // Returns immediately, cancel here if you want
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(filter(_:)))
        
//        fetchAndReload()
        
        
    }

    // ✅批量更新的使用:批量处理，绕过了NSManagedObjectContext，避免把所有数据直接加载到内存
    // 批量删除 ：NSBatchDeleteRequest
    // ⚠️因为批量更新、删除绕过了上下文，所以上下文中不会有反映
    func batchUpdate() {
        let batchUpdate = NSBatchUpdateRequest(entityName: "Venue")
        batchUpdate.propertiesToUpdate = [#keyPath(Venue.favorite): true] //需要批量更新的属性
        batchUpdate.affectedStores = coreDataStack.managedContext.persistentStoreCoordinator?.persistentStores
        // 设置返回类型为 更新的条数
        batchUpdate.resultType = .updatedObjectsCountResultType
        
        do {
            let batchResult = try coreDataStack.managedContext.execute(batchUpdate) as! NSBatchUpdateResult
            print("Records updated \(batchResult.result!)")
        } catch let error as NSError {
            print("Could not update \(error), \(error.userInfo)")
        }
    }
}

extension BubbleTea {
    
    @objc public func filter(_ sender: UIBarButtonItem) {
        let filter = BubbleTeaFilterViewController()
        filter.coreDataStack = coreDataStack
        filter.delegate = self
        navigationController?.pushViewController(filter, animated: true)
    }
    
    func importJSONSeedDataIfNeeded() {
        // ✅count的使用
        let fetchRequest = NSFetchRequest<Venue>(entityName: "Venue")
        let count = try! coreDataStack.managedContext.count(for: fetchRequest)
        guard count == 0 else { return }
        do {
            let results = try coreDataStack.managedContext.fetch(fetchRequest)
            results.forEach { coreDataStack.managedContext.delete($0) }
            coreDataStack.saveContext()
            importJSONSeedData()
        } catch let error as NSError {
            print("Error fetching: \(error), \(error.userInfo)")
        }
    }
    
    func importJSONSeedData() {
        let jsonURL = Bundle.main.url(forResource: "seed", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)

        let jsonDict = try! JSONSerialization.jsonObject(with: jsonData, options: [.allowFragments]) as! [String: Any]
        let responseDict = jsonDict["response"] as! [String: Any]
        let jsonArray = responseDict["venues"] as! [[String: Any]]

        for jsonDictionary in jsonArray {
            let venueName = jsonDictionary["name"] as? String
            let contactDict = jsonDictionary["contact"] as! [String: String]

            let venuePhone = contactDict["phone"]

            let specialsDict = jsonDictionary["specials"] as! [String: Any]
            let specialCount = specialsDict["count"] as? NSNumber

            let locationDict = jsonDictionary["location"] as! [String: Any]
            let priceDict = jsonDictionary["price"] as! [String: Any]
            let statsDict =  jsonDictionary["stats"] as! [String: Any]

            let location = VenueLocation(context: coreDataStack.managedContext)
            location.address = locationDict["address"] as? String
            location.city = locationDict["city"] as? String
            location.state = locationDict["state"] as? String
            location.zipcode = locationDict["postalCode"] as? String
            let distance = locationDict["distance"] as? NSNumber
            location.distance = distance!.floatValue

            let category = VenueCategory(context: coreDataStack.managedContext)

            let priceInfo = PriceInfo(context: coreDataStack.managedContext)
            priceInfo.priceCategory = priceDict["currency"] as? String

            let stats = Stats(context: coreDataStack.managedContext)
            let checkins = statsDict["checkinsCount"] as? NSNumber
            stats.checkinsCount = checkins!.int32Value
            let tipCount = statsDict["tipCount"] as? NSNumber
            stats.tipCount = tipCount!.int32Value

            let venue = Venue(context: coreDataStack.managedContext)
            venue.name = venueName
            venue.phone = venuePhone
            venue.specialCount = specialCount!.int32Value
            venue.location = location
            venue.category = category
            venue.priceInfo = priceInfo
            venue.stats = stats
        }
        coreDataStack.saveContext()
    }
    
    func fetchAndReload() {
        guard let fetchRequest else {
            return
        }
        do {
            venues = try coreDataStack.managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}

extension BubbleTea: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: venueCellIdentifier, for: indexPath)
        let venue = venues[indexPath.row]
        cell.textLabel?.text = venue.name
        cell.detailTextLabel?.text = venue.priceInfo?.priceCategory
        return cell
    }
}

extension BubbleTea: BubbleTeaFilterViewControllerDelegate {
    func filterViewController(filter: BubbleTeaFilterViewController, didSelectPredicate predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) {
        guard let fetchRequest = fetchRequest else {
            return
        }
        
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = nil
        // ✅数据排序与谓词过滤
        fetchRequest.predicate = predicate
        
        if let sr = sortDescriptor {
            fetchRequest.sortDescriptors = [sr]
        }
        
        fetchAndReload()
    }
}
