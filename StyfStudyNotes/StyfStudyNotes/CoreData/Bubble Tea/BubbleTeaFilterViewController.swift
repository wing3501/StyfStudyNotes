//
//  BubbleTeaFilterViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/12.
//

import UIKit
import CoreData

protocol BubbleTeaFilterViewControllerDelegate: AnyObject {
    func filterViewController(filter: BubbleTeaFilterViewController, didSelectPredicate predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?)
}

class BubbleTeaFilterViewController: UIViewController {
    
    var coreDataStack: CoreDataStack!
    
    let cellIdentifier = "cell"
    
    var firstPriceCategory = ""
    var secondPriceCategory = ""
    var thirdPriceCategory = ""
    
    var numDeals = ""
    
    weak var delegate: BubbleTeaFilterViewControllerDelegate?
    var selectedSortDescriptor: NSSortDescriptor?
    var selectedPredicate: NSPredicate?
    
    class FilterCell: UITableViewCell {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    // 多条件
    // 1.使用 AND, OR and NOT.
    // 2.使用 NSCompoundPredicate
    // 详细可参考: https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Predicates/AdditionalChapters/Introduction.html
    
    lazy var cheapVennePredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(Venue.priceInfo.priceCategory),"$")
    }()

    lazy var moderateVenuePredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(Venue.priceInfo.priceCategory),"$$")
    }()
    
    lazy var expensiveVenuePredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(Venue.priceInfo.priceCategory),"$$$")
    }()
    
    lazy var offeringDealPredicate: NSPredicate = {
        return NSPredicate(format: "%K > 0", #keyPath(Venue.specialCount))
    }()
    
    lazy var walkingDistancePredicate: NSPredicate = {
        return NSPredicate(format: "%K < 500", #keyPath(Venue.location.distance))
    }()
    
    lazy var hasUserTipsPredicate: NSPredicate = {
        return NSPredicate(format: "%K > 0", #keyPath(Venue.stats.tipCount))
    }()
    // ⚠️Core Data 不支持NSSortDescriptor和NSPredicate的Block API
    // 原因是过滤和排序发生在SQLite数据库中，因此谓词/排序描述符必须与可以编写为SQLite语句的内容很好地匹配。
    lazy var nameSortDescriptor: NSSortDescriptor = {
        let compareSelector = #selector(NSString.localizedStandardCompare(_:)) //根据当前区域设置的语言规则进行排序
        return NSSortDescriptor(key: #keyPath(Venue.name), ascending: true, selector: compareSelector)
    }()
    
    lazy var distanceSortDescriptor: NSSortDescriptor = {
        return NSSortDescriptor(key: #keyPath(Venue.location.distance), ascending: true)
    }()
    
    lazy var priceSortDescriptor: NSSortDescriptor = {
        return NSSortDescriptor(key: #keyPath(Venue.priceInfo.priceCategory), ascending: true)
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(FilterCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "搜索", style: .plain, target: self, action: #selector(search(_:)))
        
        firstPriceCategory = populateCheapVenueCountLabel()
        secondPriceCategory = populateModerateVenueCountLabel()
        thirdPriceCategory = populateExpensiveVenueCountLabel()
        
        numDeals = populateDealsCountLabel()
    }
    
    @objc public func search(_ sender: UIBarButtonItem) {
        delegate?.filterViewController(filter: self, didSelectPredicate: selectedPredicate, sortDescriptor: selectedSortDescriptor)
        navigationController?.popViewController(animated: true)
    }
}

extension BubbleTeaFilterViewController {
    // 最便宜的个数
    func populateCheapVenueCountLabel() -> String {
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: "Venue")
        fetchRequest.resultType = .countResultType
        fetchRequest.predicate = cheapVennePredicate
        
        do {
            let countResult = try coreDataStack.managedContext.fetch(fetchRequest)
            let count = countResult.first!.intValue
            let pluralized = count == 1 ? "place" : "places"
            return "\(count) bubble tea \(pluralized)"
        } catch let error as NSError {
            print("Count not fetch \(error), \(error.userInfo)")
        }
        return ""
    }
    
    func populateModerateVenueCountLabel() -> String {
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: "Venue")
        fetchRequest.resultType = .countResultType
        fetchRequest.predicate = moderateVenuePredicate
        
        do {
            let countResult = try coreDataStack.managedContext.fetch(fetchRequest)
            let count = countResult.first!.intValue
            let pluralized = count == 1 ? "place" : "places"
            return "\(count) bubble tea \(pluralized)"
        } catch let error as NSError {
            print("Count not fetch \(error), \(error.userInfo)")
        }
        return ""
    }
    //另一种方式
    func populateExpensiveVenueCountLabel() -> String {
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: "Venue")
        fetchRequest.predicate = expensiveVenuePredicate
        
        do {
            let count = try coreDataStack.managedContext.count(for: fetchRequest)
            let pluralized = count == 1 ? "place" : "places"
            return "\(count) bubble tea \(pluralized)"
        } catch let error as NSError {
            print("Count not fetch \(error), \(error.userInfo)")
        }
        return ""
    }
}

extension BubbleTeaFilterViewController {
    // 总订单数
    func populateDealsCountLabel() -> String {
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "Venue")
        fetchRequest.resultType = .dictionaryResultType
        
        let sumExpressionDesc = NSExpressionDescription()
        sumExpressionDesc.name = "sumDeals"
        
        let specialCountExp = NSExpression(forKeyPath: #keyPath(Venue.specialCount))
        // count, min, max, average, median, mode, absolute value and many more.
        sumExpressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [specialCountExp])
        sumExpressionDesc.expressionResultType = .integer32AttributeType
        
        fetchRequest.propertiesToFetch = [sumExpressionDesc]
        
        do {
            let results = try coreDataStack.managedContext.fetch(fetchRequest)
            let resultDict = results.first!
            let numDeals = resultDict["sumDeals"] as! Int
            let pluralized = numDeals == 1 ?  "deal" : "deals"
            return "\(numDeals) \(pluralized)"
        } catch let error as NSError {
            print("Count not fetch \(error), \(error.userInfo)")
        }
        return ""
    }
}

extension BubbleTeaFilterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        [3,3,4][section]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        ["Price","Most Popular","Sort By"][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let title = [
            ["$","$$","$$$"],
            ["Offering a deal","Within walking distance","Has User Tips"],
            ["Name (A-Z)","Name (Z-A)","Distance","Price"]
        ][indexPath.section][indexPath.row]
        cell.textLabel?.text = title
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.detailTextLabel?.text = firstPriceCategory
            }else if indexPath.row == 1 {
                cell.detailTextLabel?.text = secondPriceCategory
            }else {
                cell.detailTextLabel?.text = thirdPriceCategory
            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.detailTextLabel?.text = numDeals
            }
        }
        return cell
    }
}

extension BubbleTeaFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                selectedPredicate = cheapVennePredicate
            }else if indexPath.row == 1 {
                selectedPredicate = moderateVenuePredicate
            }else {
                selectedPredicate = expensiveVenuePredicate
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                selectedPredicate = offeringDealPredicate
            }else if indexPath.row == 1 {
                selectedPredicate = walkingDistancePredicate
            }else {
                selectedPredicate = hasUserTipsPredicate
            }
        } else {
            if indexPath.row == 0 {
                selectedSortDescriptor = nameSortDescriptor
            }else if indexPath.row == 1 {
                selectedSortDescriptor = nameSortDescriptor.reversedSortDescriptor as? NSSortDescriptor
            }else if indexPath.row == 2 {
                selectedSortDescriptor = distanceSortDescriptor
            }else {
                selectedSortDescriptor = priceSortDescriptor
            }
        }
        cell.accessoryType = .checkmark
    }
}
