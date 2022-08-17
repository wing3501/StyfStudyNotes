//
//  ImageTransformer.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/16.
//

import UIKit

@objc(ImageTransformer)
class ImageTransformer: ValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        true
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return UIImage(data: data)
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { return nil }
        return image.pngData()
    }
}
