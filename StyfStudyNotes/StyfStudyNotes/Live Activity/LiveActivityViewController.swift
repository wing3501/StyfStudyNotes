//
//  LiveActivityViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/11.
//  官方文档 https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities

import UIKit
import ActivityKit

@available(iOS 16.1, *)
@objc(LiveActivityViewController)
class LiveActivityViewController: UIViewController {
    
    var deliveryActivity :Activity<YFWidgetAttributes>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setTitle("启动", for: .normal)
        button.addTarget(self, action: #selector(startLiveActivity), for: .touchUpInside)
        button.backgroundColor = .green
        view.addSubview(button)
        
        let button1 = UIButton(type: .custom)
        button1.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
        button1.setTitle("更新", for: .normal)
        button1.addTarget(self, action: #selector(updateLiveActivity), for: .touchUpInside)
        button1.backgroundColor = .blue
        view.addSubview(button1)
    }
    
    
    // 启动一个实时活动
    @objc private func startLiveActivity() {
        print("启动Live Activity")
        var future = Calendar.current.date(byAdding: .minute, value: 2, to: Date())!
        future = Calendar.current.date(byAdding: .second, value: 2, to: future)!
        let date = Date.now...future
        
        let initialContentState = YFWidgetAttributes.ContentState(value: 1, driverName: "Bill James", deliveryTimer: date)
        let activityAttributes = YFWidgetAttributes(name: "名称", numberOfPizzas: 3, totalAmount: "$42.00", orderNumber: "12345")

        do {
            // deliveryActivity 可用于更新、结束
            // 只能通过APP在前台时启动，但是可以在APP处于后台时，更新、结束活动
            deliveryActivity = try Activity.request(attributes: activityAttributes, contentState: initialContentState)
            
            print("Requested a pizza delivery Live Activity \(String(describing: deliveryActivity?.id)).")
            
            // 使用异步序列进行观察
            // 观察状态 activityStateUpdates
            // 观察内容 contentState
            // 观察push token的改变 pushTokenUpdates
            // Observe updates for ongoing pizza delivery Live Activities.
            
            Task {
                for await activity in Activity<YFWidgetAttributes>.activityUpdates {
                    print("Pizza delivery details: \(activity.attributes)")
                }
            }
            // 如果APP启动了多个活动，使用以下属性进行跟踪
//            Activity.activities
            
        } catch (let error) {
            print("Error requesting pizza delivery Live Activity \(error.localizedDescription).")
        }
    }
    // 更新实时活动
    @objc private func updateLiveActivity() {
        print("更新实时活动")
        Task {
            var future = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
            future = Calendar.current.date(byAdding: .second, value: 1, to: future)!
            let date = Date.now...future
            // ⚠️ 更新的数据不能超过4kb
            let updatedDeliveryStatus = YFWidgetAttributes.ContentState(value: 2, driverName: "styf", deliveryTimer: date)
            let alertConfiguration = AlertConfiguration(title: "Delivery Update", body: "Your pizza order will arrive in 25 minutes.", sound: .default)
            // 也可以使用update(using:) 进行更新。 alertConfiguration会带一个弹窗,会显示在灵动岛？
            // On iPhone, the system doesn’t show a regular alert but instead shows the expanded Live Activity in the Dynamic Island.
            await deliveryActivity?.update(using: updatedDeliveryStatus, alertConfiguration: alertConfiguration)
        }
    }
    
    private func animateContentUpdates() {
        // 带动画的内容更新使用以下这些方法
//        opacity, move(edge:), slide, push(from:),
//        request animations for timer text with numericText(countsDown:).
    }
    
    // 结束实时活动
    private func endLiveActivity() {
        let finalDeliveryStatus = YFWidgetAttributes.ContentState(value: 2,driverName: "Anne Johnson", deliveryTimer: Date.now...Date())

        Task {
            // 默认的结束策略：用户可以随时选择删除Live Activity，也可以在活动结束四小时后系统自动将其删除。
            // 要立即从锁定屏幕中删除结束的实时活动，请使用immediate。或者，使用after（_：）指定四小时窗口内的日期
            await deliveryActivity?.end(using:finalDeliveryStatus, dismissalPolicy: .default)
        }
    }
}
