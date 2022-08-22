//
//  CoreDataDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/11.
//

// NSManagedObjectModel表示数据模型中的每种对象类型，它们的属性以及之间的关系。Core Data stack的其他部分使用它来创建对象、存储属性、保存数据
// NSPersistentStore使用不同的存储方式进行读写数据。NSQLiteStoreType、NSXMLStoreType（OSX特有）、NSBinaryStoreType、NSInMemoryStoreType
// NSPersistentStoreCoordinator 是 NSManagedObjectModel 和 NSPersistentStore之间的桥梁。它了解NSManagedObjectModel，并发送数据给Store,也从Store抓取数据。
        //也隐藏了一些底层细节。比如NSManagedObjectContext不需要了解它使用的是哪种存储。针对不同的NSPersistentStore，提供了统一的接口去操作NSManagedObjectContext
// NSManagedObjectContext是一个内存草稿箱。所有Core Data objects都在一个上下文中。
        // 1 NSManagedObjectContext 管理着 NSManagedObject的生命周期，无论是创建的，还是抓取的
        // 2 NSManagedObjectContext 和 NSManagedObject 关系非常耦合  game.managedObjectContext
        // 3 NSManagedObject一旦与某个上下文关联，则整个生命周期都保持这种关联
        // 4 一个应用可以使用多个上下文。因为NSManagedObjectContext是内存暂存器、草稿箱，所以把相同的数据对象加载到不同的上下文
        // 5 NSManagedObjectContext 和 NSManagedObject都不是线程安全的
// NSPersistentContainer iOS10新增的一个组件，协调上面四个Core Data Stack类。它是一个将所有内容放在一起的容器。您不必浪费时间编写样板代码来将所有四个堆栈组件连接在一起，只需初始化NSPersistentContainer，加载其持久存储，就可以了。

import UIKit
@objc(CoreDataDemo)
class CoreDataDemo: UIViewController {

    var dataArray: [UIViewController.Type] = [DogWalk.self,BubbleTea.self,WorldCup.self,UnCloudNotes.self,EmployeeDirectory.self,SurfJournal.self]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension CoreDataDemo: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(dataArray[indexPath.row])"
        return cell
    }
}

extension CoreDataDemo: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcClass = dataArray[indexPath.row]
        let vc = vcClass.init()
        if vcClass is EmployeeDirectory.Type {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CoreDataDemo {
    // 创建抓取请求的五种方式
    func fiveFetch() {
//        // 1
//        let fetchRequest1 = NSFetchRequest<Venue>()
//        let entity = NSEntityDescription.entity(forEntityName: "Venue", in: managedContext)!
//        fetchRequest1.entity = entity
//        // 2 上一个方法的便利版本
//        let fetchRequest2 = NSFetchRequest<Venue>(entityName: "Venue")
//        // 3 生成NSManagedObject subclass，Xcode生成的方法
//        let fetchRequest3: NSFetchRequest<Venue> = Venue.fetchRequest()
//        // 4 在Xcode data model editer中可配置的
//        let fetchRequest4 = managedObjectModel.fetchRequestTemplate(forName: "venueFR")
//        // 5 和第4个类似。带的参数会用在谓词中
//        let fetchRequest5 = managedObjectModel.fetchRequestFromTemplate(withName: "venueFR", substitutionVariables: ["NAME" : "Vivi Bubble Tea"])
    }
}
