//
//  UIApplication+++.swift
//  
//
//  Created by styf on 2022/8/30.
//

import SwiftUI

// MARK: - 通过keywindow获取
// 使用 @Environment(\.safeAreaInsets) private var safeAreaInsets  可以通过环境值获取到根视图的 safeAreaInsets

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private struct WindowSafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[WindowSafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
