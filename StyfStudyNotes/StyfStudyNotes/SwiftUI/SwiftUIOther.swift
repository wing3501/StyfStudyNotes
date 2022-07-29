//
//  SwiftUIOther.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import UIKit
import SwiftUI

@objc(SwiftUIOther)
@objcMembers
class SwiftUIOther: UIHostingController<SwiftUIOtherList> {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(rootView: SwiftUIOtherList())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: SwiftUIOtherList())
    }
    
    init() {
        super.init(rootView: SwiftUIOtherList())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
