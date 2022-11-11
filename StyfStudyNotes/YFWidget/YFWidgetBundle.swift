//
//  YFWidgetBundle.swift
//  YFWidget
//
//  Created by styf on 2022/11/11.
//

import WidgetKit
import SwiftUI

@main
struct YFWidgetBundle: WidgetBundle {
    var body: some Widget {
        YFWidget()
        if #available(iOS 16.1, *) {
            YFWidgetLiveActivity()
        }
    }
}
