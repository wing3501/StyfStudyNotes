//
//  EmployeeDirectory.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/18.
//

import UIKit
import CoreData

// binary data类型的属性一般保存在数据库，如果打开Allows External Storage，Core Data会自动决定保存在数据到一个单独的磁盘文件中还是保留在数据库中
// fetchBatchSize可以限制抓取请求的数量，当需要更多数据的时候，Core Data会自动执行更多批操作   。限制抓取条数 = 先抓取总条数，访问到了再懒加载数据
//      也可以使用谓词来限制抓取，更严格的谓词条件放在最前面更有高效。特别是涉及字符串比较的条件。"(active == YES) AND (name CONTAINS[cd] %@)" 比 "(name CONTAINS[cd] %@) AND (active == YES)"高效

// 优化步骤：
// 1 优化图片内存占用，懒加载二进制图片数据。大图单独放一个entity,使用缩略图代替原来不必要使用原图的属性
// 2 抓取列表数据的，使用fetchBatchSize 懒加载数据
// 3 计算分组后，每组数量的。 只抓取用来分组的属性，配合count函数
// 4 只需要抓取条数的，使用count方法代替fetch方法

class EmployeeDirectory: UITabBarController {

    lazy var coreDataStack = CoreDataStack(modelName: "EmployeeDirectory")
    
    let amountToImport = 50
    let addSalesRecords = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        importJSONSeedDataIfNeeded()
        
        let vc1 = EmployeeListViewController()
        vc1.coreDataStack = coreDataStack
        vc1.title = "employees"
        
        let vc2 = DepartmentListViewController()
        vc2.coreDataStack = coreDataStack
        vc2.title = "departments"
        
        self.viewControllers = [UINavigationController(rootViewController: vc1),UINavigationController(rootViewController: vc2)]
        
        self.tabBar.isTranslucent = false
    }
    
    func importJSONSeedDataIfNeeded() {
      var importRequired = false

      let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()

      var employeeCount = -1
      do {
        employeeCount = try coreDataStack.mainContext.count(for: fetchRequest)
      } catch {
        print("ERROR: employee count failed")
      }

      if employeeCount != amountToImport {
        importRequired = true
      }

      if !importRequired, addSalesRecords {
          let salesFetch: NSFetchRequest<Sale> = Sale.fetchRequest()

          var salesCount = -1
          do {
            salesCount = try coreDataStack.mainContext.count(for: salesFetch)
          } catch {
            print("Error: sales count failed")
          }

          if salesCount == 0 {
            importRequired = true
          }
      }

      if importRequired {
        // 批量删除用户
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Employee.fetchRequest())
        deleteRequest.resultType = .resultTypeCount

        let deletedObjectCount: Int
        do {
          let resultBox = try coreDataStack.mainContext.execute(deleteRequest) as! NSBatchDeleteResult
          deletedObjectCount = resultBox.result as! Int
        } catch let nserror as NSError {
          print("Error: \(nserror.localizedDescription)")
          abort()
        }

        print("Removed \(deletedObjectCount) objects.")
        coreDataStack.saveContext()
        let records = max(0, min(500, amountToImport))
        importJSONSeedData(records)
      }
    }
    
    func importJSONSeedData(_ records: Int) {

      let jsonURL = Bundle.main.url(forResource: "EmployeeSeed", withExtension: "json")!
      let jsonData = try! Data(contentsOf: jsonURL)

      var jsonArray: [[String: AnyObject]] = []
      do {
        jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String: AnyObject]]
      } catch let error as NSError {
        print("Error: \(error.localizedDescription)")
        abort()
      }

      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"

      var counter = 0
      for jsonDictionary in jsonArray {

        counter += 1

        let guid = jsonDictionary["guid"] as! String
        let active = jsonDictionary["active"] as! Bool
        let name = jsonDictionary["name"] as! String
        let vacationDays = jsonDictionary["vacationDays"] as! Int16
        let department = jsonDictionary["department"] as! String
        let startDate = jsonDictionary["startDate"] as! String
        let email = jsonDictionary["email"] as! String
        let phone = jsonDictionary["phone"] as! String
        let address = jsonDictionary["address"] as! String
        let about = jsonDictionary["about"] as! String
        let picture = jsonDictionary["picture"] as! String
        let pictureComponents = picture.components(separatedBy: ".")
        let pictureFileName = pictureComponents[0]
        let pictureFileExtension = pictureComponents[1]
        let pictureURL = Bundle.main.url(forResource: pictureFileName,
                                         withExtension: pictureFileExtension)!
        let pictureData = try! Data(contentsOf: pictureURL)

        let employee = Employee(context: coreDataStack.mainContext)
        employee.guid = guid
        employee.active = active
        employee.name = name
        employee.vacationDays = vacationDays
        employee.department = department
        employee.startDate = dateFormatter.date(from: startDate)
        employee.email = email
        employee.phone = phone
        employee.address = address
        employee.about = about
        employee.pictureThumbnail = imageDataScaledToHeight(pictureData, height: 120)
          
        let pictureObject = EmployeePicture(context: coreDataStack.mainContext)
        pictureObject.picture = pictureData
        employee.picture = pictureObject

        if addSalesRecords {
          addSalesRecordsToEmployee(employee)
        }

        if counter == records {
          break
        }

        if counter % 20 == 0 {
          coreDataStack.saveContext()
          coreDataStack.mainContext.reset()
        }
      }

      coreDataStack.saveContext()
      coreDataStack.mainContext.reset()
      print("Imported \(counter) employees.")
    }
    
    func imageDataScaledToHeight(_ imageData: Data, height: CGFloat) -> Data {

      let image = UIImage(data: imageData)!
      let oldHeight = image.size.height
      let scaleFactor = height / oldHeight
      let newWidth = image.size.width * scaleFactor
      let newSize = CGSize(width: newWidth, height: height)
      let newRect = CGRect(x: 0, y: 0, width: newWidth, height: height)

      UIGraphicsBeginImageContext(newSize)
      image.draw(in: newRect)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return newImage!.jpegData(compressionQuality: 0.8)!
    }
    
    func addSalesRecordsToEmployee(_ employee: Employee) {
      let numberOfSales = 1000 + arc4random_uniform(5000)
      for _ in 0...numberOfSales {
        let sale = Sale(context: coreDataStack.mainContext)
        sale.employee = employee
          sale.amount = NSNumber(value: 3000 + arc4random_uniform(20000)).int16Value
      }
      print("added \(String(describing: employee.sales?.count)) sales")
    }
}
