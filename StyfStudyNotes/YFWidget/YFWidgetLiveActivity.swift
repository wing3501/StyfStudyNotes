//
//  YFWidgetLiveActivity.swift
//  YFWidget
//
//  Created by styf on 2022/11/11.
//  Displaying live data with Live Activities  https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities
//

// ✅ 在app中，使用areActivitiesEnabled判断是否允许使用 Live Activities
// ✅ 使用异步流activityEnablementUpdates，来获取权限的更新   https://developer.apple.com/documentation/activitykit/activityauthorizationinfo/activityenablementupdates-swift.property
// ✅ 一个app可以启动多个活动，但是一个设备启动活动的个数是有限的，所以启动活动可能失败，需要正确处理错误

import ActivityKit
import WidgetKit
import SwiftUI
// 1. 设置用于描述静态、动态的数据模型
@available(iOS 16.1, *)
struct YFWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
        var driverName: String
        var deliveryTimer: ClosedRange<Date>
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
    var numberOfPizzas: Int
    var totalAmount: String
    var orderNumber: String
    
    
}

@available(iOS 16.1, *)
struct YFWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        // 2. 创建配置
        ActivityConfiguration(for: YFWidgetAttributes.self) { context in
            // 锁屏时出现的样式、以及不支持灵动岛的设备非锁屏时的样式
            // Lock screen/banner UI goes here
            
            //如果实时活动的高度超过160点，系统可能会在锁定屏幕上截断该活动。
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            // 出现在灵动岛时的样式
            
            DynamicIsland {
                // 完全展开时的内容
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
//                    Text("Leading")
                    Label("\(context.attributes.numberOfPizzas) Pizzas", systemImage: "bag")
                        .foregroundColor(.indigo)
                        .font(.title2)
                    // 如果内容太多无法显示在前导位置，使用belowIfTooWide渲染在下方
//                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                
                
                DynamicIslandExpandedRegion(.trailing) {
//                    Text("Trailing")
                    Label {
                        Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                            .monospacedDigit()
                    } icon: {
                        Image(systemName: "timer")
                            .foregroundColor(.indigo)
                    }
                    .font(.title2)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.state.driverName) is on their way!")
                        .lineLimit(1)
                        .font(.caption)
                }
                DynamicIslandExpandedRegion(.bottom) {
//                    Text("Bottom")
                    // more content
                    Button {
                        // Deep link into your app.
                    } label: {
                        Label("Call driver", systemImage: "phone")
                    }
                    .foregroundColor(.indigo)
                }
            } compactLeading: {
//                Text("L")
                Label {
                    Text("\(context.attributes.numberOfPizzas) Pizzas")
                } icon: {
                    Image(systemName: "bag")
                        .foregroundColor(.indigo)
                }
                .font(.caption2)
            } compactTrailing: {
//                Text("T")
                Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            } minimal: {
//                Text("Min")
                Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
//               ✅     .widgetURL(<#T##url: URL?##URL?#>) 使用widgetURL或Link来处理跳转
                // 如果没有明确指明widgetURL或Link，系统将启动APP把NSUserActivity
                // 传给  scene(_:willContinueUserActivityWithType:) 和 scene(_:continue:) 方法
                // 实现这两个回调，检查 NSUserActivity 的 activityType 是否是 NSUserActivityTypeLiveActivity
                
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)// 灵动岛默认黑底白字，使用keylineTint修改
            .contentMargins(.trailing, 8, for: .expanded) // 修改展开时的默认边距
        }
    }
}

//struct LockScreenLiveActivityView: View {
//    let context: ActivityViewContext<YFWidgetAttributes>
//    var body: some View {
//        VStack {
//            Text("Hello")
//        }
//        .activityBackgroundTint(Color.cyan)
//        .activitySystemActionForegroundColor(Color.black)
//    }
//}
@available(iOS 16.1, *)
struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<YFWidgetAttributes>
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(context.state.driverName) is on their way with your pizza!")
            Spacer()
            HStack {
                Spacer()
                Label {
                    Text("\(context.attributes.numberOfPizzas) Pizzas")
                } icon: {
                    Image(systemName: "bag")
                        .foregroundColor(.indigo)
                }
                .font(.title2)
                Spacer()
                Label {
                    Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 50)
                        .monospacedDigit()
                } icon: {
                    Image(systemName: "timer")
                        .foregroundColor(.indigo)
                }
                .font(.title2)
                Spacer()
            }
            Spacer()
        }
        .activitySystemActionForegroundColor(.indigo)// 辅助按钮文字颜色
        .activityBackgroundTint(.cyan)
        // 想修改背景色的半透明性，使用opacity(_:)
        
    }
}
