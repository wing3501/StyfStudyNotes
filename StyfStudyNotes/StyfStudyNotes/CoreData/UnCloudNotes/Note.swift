//
//  Note.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/16.
//

import UIKit
import Foundation
import CoreData

class Note: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var body: String
    @NSManaged var dateCreated: Date!
    @NSManaged var displayIndex: NSNumber!
    
    @NSManaged var image: UIImage?
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        dateCreated = Date()
    }
}
