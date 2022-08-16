//
//  NoteCoreDataStack.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/16.
//

import Foundation
import CoreData

protocol UsesCoreDataObjects: AnyObject {
    var managedObjectContext: NSManagedObjectContext? { get set }
}

class NoteCoreDataStack {
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    var savingContext: NSManagedObjectContext {
        return storeContainer.newBackgroundContext()
    }
    
    var storeName: String = "UnCloudNotesDataModel"
    var storeURL : URL {
        let storePaths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        let storePath = storePaths[0] as NSString
        let fileManager = FileManager.default
      
        do {
            try fileManager.createDirectory(atPath: storePath as String,withIntermediateDirectories: true,attributes: nil)
        } catch {
            print("Error creating storePath \(storePath): \(error)")
        }
      
        let sqliteFilePath = storePath.appendingPathComponent(storeName + ".sqlite")
        return URL(fileURLWithPath: sqliteFilePath)
    }
    
    lazy var storeDescription: NSPersistentStoreDescription = {
        let description = NSPersistentStoreDescription(url: self.storeURL)
        return description
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.persistentStoreDescriptions = [self.storeDescription]
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    func saveContext () {
        guard managedContext.hasChanges else { return }

        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
