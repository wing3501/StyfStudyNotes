//
//  WWDCDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/6/20.
//

import UIKit
import SwiftUI

@objc(WWDCDemo)
@objcMembers
class WWDCDemo: UIHostingController<WWDCDemoList> {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(rootView: WWDCDemoList())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: WWDCDemoList())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
