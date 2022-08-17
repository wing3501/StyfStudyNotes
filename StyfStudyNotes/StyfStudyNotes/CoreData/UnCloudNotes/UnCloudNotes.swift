//
//  UnCloudNotes.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/16.
//

import UIKit
import CoreData


// 手动数据迁移步骤
// 1.添加一个新版本的DataModel
// 2.创建一个新的entity名为Attachment,设置Module为Current Product Module
// 3.两个实体建立联系
// 4.完成所有新DataModel的修改后，新建Mapping Model文件
// 5.删除生成的无用关系，处理属性映射，修改Attachment映射的Source，设置映射的过滤条件比如image != nil
// 6.处理关系映射，Source Fetch填Auto Generate Value Expression，Key Path填$source，Mapping Name填NoteToNote
// 7.关闭NSPersistentStoreDescription的自动推断属性


// 轻量级数据迁移步骤
// 1.选中DataModel,点击Editor菜单，选择Add Model Version
// 2.选中新建的DataModel,右侧菜单Model Verson选中为新建版本
// 3.检查一下Module是否为Current Product Module

//https://developer.apple.com/ documentation/coredata/using_lightweight_migration.
// 满足轻量级数据迁移的一些常见条件：
// 1.删除实体、属性或关系
// 2.使用renamingIdentifier重命名实体、属性或关系
// 3.添加新的可选属性
// 4.添加新的必需属性,但是有默认值
// 5.将可选属性更改为非可选属性，并指定默认值
// 6.将非可选属性更改为可选属性
// 7.改变实体层次结构
// 8.添加新的父实体，并在层次结构中上下移动属性
// 9.将一对一关系改为一对多关系
// 10.将非有序一对多关系改为有序的一对多关系

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
        tableView.register(UINib(nibName: "NoteImageTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteCellWithImage")
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
//        let createVC = CreateNoteViewController(nibName: "CreateNoteViewController", bundle: nil)
        let createVC = CreateImageNoteViewController(nibName: "CreateImageNoteViewController", bundle: nil)
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
        let note = notes.object(at: indexPath)
        let cell: NoteTableViewCell
        if note.image == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellWithImage", for: indexPath) as! NoteImageTableViewCell
        }
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
