//
//  LiveActivityViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/11.
//

import UIKit
import ActivityKit

@available(iOS 16.1, *)
@objc(LiveActivityViewController)
class LiveActivityViewController: UIViewController {
    
    var deliveryActivity :Activity<YFWidgetAttributes>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    @available(iOS 16.1, *)
    private func startLiveActivity() {
        print("启动Live Activity")
        var future = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
        future = Calendar.current.date(byAdding: .second, value: 1, to: future)!
        let date = Date.now...future
        
        let initialContentState = YFWidgetAttributes.ContentState(value: 1, driverName: "Bill James", deliveryTimer: date)
        let activityAttributes = YFWidgetAttributes(name: "名称", numberOfPizzas: 3, totalAmount: "$42.00", orderNumber: "12345")

        do {
            deliveryActivity = try Activity.request(attributes: activityAttributes, contentState: initialContentState)
            
//            print("Requested a pizza delivery Live Activity \(String(describing: deliveryActivity.id)).")
        } catch (let error) {
            print("Error requesting pizza delivery Live Activity \(error.localizedDescription).")
        }
    }
}
