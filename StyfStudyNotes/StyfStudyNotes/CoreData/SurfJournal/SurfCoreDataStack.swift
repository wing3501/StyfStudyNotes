//
//  SurfCoreDataStack.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/22.
//

import Foundation
import CoreData

class SurfCoreDataStack {
    // MARK: Properties
    private let modelName: String

    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        self.seedCoreDataContainerIfFirstLaunch()
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: Initializers
    init(modelName: String) {
        self.modelName = modelName
    }
}

extension SurfCoreDataStack {
    func saveContext () {
        guard mainContext.hasChanges else { return }

        do {
            try mainContext.save()
        } catch let nserror as NSError {
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

private extension SurfCoreDataStack {
    
    // 拷贝数据库到目标地址
    func seedCoreDataContainerIfFirstLaunch() {

        // 1
        let previouslyLaunched = UserDefaults.standard.bool(forKey: "previouslyLaunched")
        if !previouslyLaunched {
        UserDefaults.standard.set(true, forKey: "previouslyLaunched")

        // Default directory where the CoreDataStack will store its files
        let directory = NSPersistentContainer.defaultDirectoryURL()
        let url = directory.appendingPathComponent(modelName + ".sqlite")

        // 2: Copying the SQLite file
        let seededDatabaseURL = Bundle.main.url(forResource: modelName, withExtension: "sqlite")!
        _ = try? FileManager.default.removeItem(at: url)
        do {
            try FileManager.default.copyItem(at: seededDatabaseURL, to: url)
        } catch let nserror as NSError {
            fatalError("Error: \(nserror.localizedDescription)")
        }

        // 3: Copying the SHM file
        let seededSHMURL = Bundle.main.url(forResource: modelName, withExtension: "sqlite-shm")!
        let shmURL = directory.appendingPathComponent(modelName + ".sqlite-shm")
        _ = try? FileManager.default.removeItem(at: shmURL)
        do {
            try FileManager.default.copyItem(at: seededSHMURL, to: shmURL)
        } catch let nserror as NSError {
            fatalError("Error: \(nserror.localizedDescription)")
        }

        // 4: Copying the WAL file
        let seededWALURL = Bundle.main.url(forResource: modelName, withExtension: "sqlite-wal")!
        let walURL = directory.appendingPathComponent(modelName + ".sqlite-wal")
        _ = try? FileManager.default.removeItem(at: walURL)
        do {
            try FileManager.default.copyItem(at: seededWALURL, to: walURL)
        } catch let nserror as NSError {
            fatalError("Error: \(nserror.localizedDescription)")
        }

        print("Seeded Core Data")
      }
    }
}
