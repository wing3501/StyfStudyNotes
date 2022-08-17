//
//  ImageAttachment.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/17.
//

import UIKit
import CoreData

class ImageAttachment: Attachment {
    @NSManaged var image: UIImage?
    @NSManaged var width: Float
    @NSManaged var height: Float
    @NSManaged var caption: String
}
