//
//  DataMigrationManager.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/17.
//

import Foundation
import CoreData

class DataMigrationManager {
    let enableMigrations: Bool
    let modelName: String
    let storeName: String = "UnCloudNotesDataModel"
    
    init(modelNamed: String, enableMigrations: Bool = false) {
        self.modelName = modelNamed
        self.enableMigrations = enableMigrations
    }
    
    var stack: NoteCoreDataStack {
        // 如果当前Bundle里有更高版本的数据对象模型，而沙盒里的持久化存储还是低版本的，说明需要进行数据迁移了
        guard enableMigrations,!store(at: storeURL, isCompatibleWithModel: currentModel) else { return NoteCoreDataStack(modelName: modelName) }
        performMigration()
        return NoteCoreDataStack(modelName: modelName)
    }
    // 当前最新的数据对象模型
    private lazy var currentModel: NSManagedObjectModel = .model(named: self.modelName)
    
    private var applicationSupportURL: URL {
        let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory,.userDomainMask, true).first
        return URL(fileURLWithPath: path!)
    }
    
    private lazy var storeURL: URL = {
        let storeFileName = "\(self.storeName).sqlite"
        return URL(fileURLWithPath: storeFileName,relativeTo: self.applicationSupportURL)
    }()
    // 返回与目前沙盒的持久化存储版本相匹配的那个数据对象模型
    // 因为Core Data API没有让持久化存储返回对应的数据对象模型的版本。所以，暴力法，拿所有版本的数据对象模型挨个去和持久化存储的元数据去匹配
    private var storeModel: NSManagedObjectModel? {
        return NSManagedObjectModel.modelVersionsFor(modelNamed: modelName).filter {
            self.store(at: storeURL, isCompatibleWithModel: $0)
        }.first
    }
    
    // 持久化存储是否与指定数据模型相匹配
    private func store(at storeURL: URL,isCompatibleWithModel model: NSManagedObjectModel) -> Bool {
        let storeMetadata = metadataForStoreAtURL(storeURL: storeURL)
        return model.isConfiguration(withName: nil,compatibleWithStoreMetadata:storeMetadata)
    }
    // 返回持久化存储的元数据信息
    private func metadataForStoreAtURL(storeURL: URL) -> [String: Any] {
        let metadata: [String: Any]
        do {
            metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType,at: storeURL, options: nil)
        } catch {
            metadata = [:]
            print("Error retrieving metadata for store at URL:\(storeURL): \(error)")
        }
        return metadata
    }
    
    //执行数据迁移
    func performMigration() {
        if !currentModel.isVersion4 {
            fatalError("Can only handle migrations to version 4!")
        }
        
        if let storeModel = self.storeModel {
          if storeModel.isVersion1 {// 1-2
              let destinationModel = NSManagedObjectModel.version2
              migrateStoreAt(URL: storeURL,fromModel: storeModel,toModel: destinationModel)
              performMigration() // 递归继续升级
          } else if storeModel.isVersion2 {// 2-3
              let destinationModel = NSManagedObjectModel.version3
              let mappingModel = NSMappingModel(from: nil,forSourceModel: storeModel,destinationModel: destinationModel)
              migrateStoreAt(URL: storeURL,fromModel: storeModel,toModel: destinationModel,mappingModel: mappingModel)
              performMigration() // 递归继续升级
          } else if storeModel.isVersion3 {// 3-4
              let destinationModel = NSManagedObjectModel.version4
              let mappingModel = NSMappingModel(from: nil,forSourceModel: storeModel,destinationModel: destinationModel)
              migrateStoreAt(URL: storeURL,fromModel: storeModel,toModel: destinationModel,mappingModel: mappingModel)
          } }
    }
    
    /// 迁移数据
    /// - Parameters:
    ///   - storeURL: 存储位置
    ///   - from: 源数据模型
    ///   - to: 目标数据模型
    ///   - mappingModel: 映射关系
    private func migrateStoreAt(URL storeURL: URL,fromModel from: NSManagedObjectModel,toModel to: NSManagedObjectModel,mappingModel: NSMappingModel? = nil) {
        // 1 创建一个系统的数据迁移管理器
        let migrationManager = NSMigrationManager(sourceModel: from, destinationModel: to)
        // 2 没有传入映射模型，就创建一个系统推断的
        var migrationMappingModel: NSMappingModel
        if let mappingModel = mappingModel {
            migrationMappingModel = mappingModel
        } else {
            migrationMappingModel = try! NSMappingModel.inferredMappingModel(forSourceModel: from, destinationModel: to) //自动推断的，比如1-2
        }
        // 3 数据迁移需要第二个数据存储文件，所以建一个临时存储文件
        let targetURL = storeURL.deletingLastPathComponent()
        let destinationName = storeURL.lastPathComponent + "~1"
        let destinationURL = targetURL.appendingPathComponent(destinationName)
        print("From Model: \(from.entityVersionHashesByName)")
        print("To Model: \(to.entityVersionHashesByName)")
        print("Migrating store \(storeURL) to \(destinationURL)")
        print("Mapping model: \(String(describing: mappingModel))")
        // 4 使用系统的数据迁移管理器进行数据迁移到临时存储文件
        let success: Bool
        do {
            try migrationManager.migrateStore(from: storeURL,sourceType: NSSQLiteStoreType,options: nil,with: migrationMappingModel,toDestinationURL:destinationURL,destinationType: NSSQLiteStoreType,destinationOptions: nil)
            success = true
        } catch {
            success = false
            print("Migration failed: \(error)")
        }
        
        // 5 如果迁移成功，删除原来的数据存储，将临时存储文件改名
        if success {
            print("Migration Completed Successfully")
            let fileManager = FileManager.default
            do {
                try fileManager.removeItem(at: storeURL)
                try fileManager.moveItem(at: destinationURL,to: storeURL)
            } catch {
                print("Error migrating \(error)")
            }
        }
    }
}

extension NSManagedObjectModel {
    // 当Xcode将您的应用程序编译到其应用程序包中时，它还将编译您的数据模型。
    // 应用程序包的根目录下将有一个.momd文件夹，其中包含.mom文件。
    // MOM或Managed Object Model文件是.xcdatamodel文件的编译版本。每个数据模型版本都有一个.mom。
    // /Users/styf/Library/Developer/Xcode/DerivedData/StyfStudyNotes-bzedftgflimzhifdhaasumzwxpcb/Build/Products/Debug-iphoneos/StyfStudyNotes.app/UnCloudNotesDataModel.momd
//    -rw-r--r--  1 styf  staff   1.7K  8 17 17:13 UnCloudNotesDataModel v2.mom
//    -rw-r--r--  1 styf  staff   2.3K  8 17 17:13 UnCloudNotesDataModel v3.mom
//    -rw-r--r--  1 styf  staff   3.2K  8 17 17:13 UnCloudNotesDataModel v4.mom
//    -rw-r--r--  1 styf  staff   6.5K  8 17 17:13 UnCloudNotesDataModel v4.omo
//    -rw-r--r--  1 styf  staff   1.5K  8 17 17:13 UnCloudNotesDataModel.mom
//    -rw-r--r--  1 styf  staff   608B  8 17 17:13 VersionInfo.plist
    
    // 返回所有数据对象模型的URL
    private class func modelURLs(in modelFolder: String) -> [URL] {
        return Bundle.main.urls(forResourcesWithExtension: "mom",subdirectory: "\(modelFolder).momd") ?? []
    }
    // 返回所有数据对象模型
    class func modelVersionsFor(modelNamed modelName: String) -> [NSManagedObjectModel] {
        return modelURLs(in: modelName).compactMap(NSManagedObjectModel.init)
    }
    // 返回指定名称的数据对象模型
    class func uncloudNotesModel(named modelName: String) -> NSManagedObjectModel {
        let model = modelURLs(in: "UnCloudNotesDataModel")
            .filter { $0.lastPathComponent == "\(modelName).mom" }
            .first
            .flatMap(NSManagedObjectModel.init)
        return model ?? NSManagedObjectModel()
    }
    
    // Core Data自动查找文件里的顶级版本来初始化数据对象模型，仅适用于已经版本化了的数据对象模型
    class func model(named modelName: String, in bundle: Bundle = .main) -> NSManagedObjectModel {
        return  bundle.url(forResource: modelName, withExtension: "momd").flatMap(NSManagedObjectModel.init) ?? NSManagedObjectModel()
    }
    
    class var version1: NSManagedObjectModel {
        return uncloudNotesModel(named: "UnCloudNotesDataModel")
    }
    
    var isVersion1: Bool {
        return self == type(of: self).version1
    }
    
    class var version2: NSManagedObjectModel {
        return uncloudNotesModel(named: "UnCloudNotesDataModel v2")
    }
    
    var isVersion2: Bool {
        return self == type(of: self).version2
    }
    
    class var version3: NSManagedObjectModel {
        return uncloudNotesModel(named: "UnCloudNotesDataModel v3")
    }
    
    var isVersion3: Bool {
        return self == type(of: self).version3
    }
    
    class var version4: NSManagedObjectModel {
        return uncloudNotesModel(named: "UnCloudNotesDataModel v4")
    }
    
    var isVersion4: Bool {
        return self == type(of: self).version4
    }
    
    static func == (firstModel: NSManagedObjectModel,otherModel: NSManagedObjectModel) -> Bool {
        return firstModel.entitiesByName == otherModel.entitiesByName
    }
}
 
