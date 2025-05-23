//
//  AttachmentToImageAttachmentMigrationPolicyV3toV4.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/17.
//

import Foundation
import CoreData
import UIKit

let errorDomain = "Migration"
// Attachment映射到ImageAttachment的策略
class AttachmentToImageAttachmentMigrationPolicyV3toV4: NSEntityMigrationPolicy {
    
    //这个方法是迁移管理器用来创建目标实体的
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        let description = NSEntityDescription.entity(forEntityName: "ImageAttachment",in: manager.destinationContext)
        // 迁移管理器使用两个Core Data堆栈，所以这里使用目标上下文
        // 通过实体描述、目标上下文创建一个目标实体
        let newAttachment = ImageAttachment(entity: description!,insertInto: manager.destinationContext)
        
        func traversePropertyMappings(block:(NSPropertyMapping, String) -> ()) throws {
            if let attributeMappings = mapping.attributeMappings {
                for propertyMapping in attributeMappings {
                    if let destinationName = propertyMapping.name {
                        block(propertyMapping, destinationName)
                    } else {
                        let message = "Attribute destination not configured properly"
                        let userInfo = [NSLocalizedFailureReasonErrorKey: message]
                        throw NSError(domain: errorDomain,code: 0, userInfo: userInfo)
                    }
                }
            }else {
                let message = "No Attribute Mappings found!"
                let userInfo = [NSLocalizedFailureReasonErrorKey: message]
                throw NSError(domain: errorDomain,code: 0, userInfo: userInfo)
            }
        }
        // 处理能从源模型直接迁移过去的属性
        try traversePropertyMappings(block: { propertyMapping, destinationName in
            if let valueExpression = propertyMapping.valueExpression {
                let context: NSMutableDictionary = ["source": sInstance]
                guard let destinationValue = valueExpression.expressionValue(with: sInstance,context: context) else { return }
                newAttachment.setValue(destinationValue,forKey: destinationName)
            }
        })
        // 处理源模型中没有的，无法直接迁移的属性
        if let image = sInstance.value(forKey: "image") as? UIImage {
            newAttachment.setValue(image.size.width, forKey: "width")
            newAttachment.setValue(image.size.height, forKey: "height")
        }
        
        let body = sInstance.value(forKeyPath: "note.body") as? NSString ?? ""
        newAttachment.setValue(body.substring(to: 80), forKey: "caption")
        // 关联源模型对象与目标对象
        manager.associate(sourceInstance: sInstance,withDestinationInstance: newAttachment,for: mapping)
    }
}
