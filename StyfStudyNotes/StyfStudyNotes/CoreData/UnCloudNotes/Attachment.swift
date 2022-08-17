//
//  Attachment.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/17.
//

import UIKit
import CoreData

class Attachment: NSManagedObject {
    @NSManaged var dateCreated: Date
//    @NSManaged var image: UIImage? //v3-v4
    @NSManaged var note: Note?
}
