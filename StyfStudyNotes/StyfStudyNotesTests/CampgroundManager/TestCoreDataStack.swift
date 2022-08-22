//
//  TestCoreDataStack.swift
//  StyfStudyNotesTests
//
//  Created by styf on 2022/8/18.
//

import Foundation
import StyfStudyNotes
import CoreData

class TestCoreDataStack: CampgroundCoreDataStack {
    convenience init() {
        self.init(modelName: "CampgroundManager")
    }

    override init(modelName: String) {
        super.init(modelName: modelName)

        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType //只创建内存存储

        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        // 重写
        self.storeContainer = container
    }
}
