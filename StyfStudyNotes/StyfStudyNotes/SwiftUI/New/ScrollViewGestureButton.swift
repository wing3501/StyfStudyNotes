//
//  ScrollViewGestureButton.swift
//
//
//  Created by styf on 2022/11/28.
//

import SwiftUI

struct ScrollViewGestureButton<Label: View>: View {

    init(
        doubleTapTimeoutout: TimeInterval = 0.5,
        longPressTime: TimeInterval = 1,
        pressAction: @escaping () -> Void = {},
        releaseAction: @escaping () -> Void = {},
        endAction: @escaping () -> Void = {},
        longPressAction: @escaping () -> Void = {},
        doubleTapAction: @escaping () -> Void = {},
        label: @escaping () -> Label
    ) {
        self.style = ScrollViewGestureButtonStyle(
            pressAction: pressAction,
            doubleTapTimeoutout: doubleTapTimeoutout,
            doubleTapAction: doubleTapAction,
            longPressTime: longPressTime,
            longPressAction: longPressAction,
            endAction: endAction)
        self.releaseAction = releaseAction
        self.label = label
    }

    var label: () -> Label
    var style: ScrollViewGestureButtonStyle
    var releaseAction: () -> Void

    var body: some View {
        Button(action: releaseAction, label: label)
            .buttonStyle(style)
    }
}

