//
//  NotificationViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/15.
//

import UIKit
import Combine

extension Notification.Name {
    static let myExampleNotification = Notification.Name("an-example-notification")
}

class NotificationViewController: UIViewController {

    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let myUserInfo = ["foo": "bar"]
        let note = Notification(name: .myExampleNotification, userInfo: myUserInfo)
        
        
        
//        let sub = NotificationCenter.default.publisher(for: NSControl.textDidChangeNotification,
//                                                       object: filterField)
//            .map { ($0.object as! NSTextField).stringValue }
//            .assign(to: \MyViewModel.filterString, on: myViewModel)
        
        cancellable = NotificationCenter.default.publisher(for: .myExampleNotification, object: nil)
            // can't use the object parameter to filter on a value reference, only class references, but
            // filtering on 'nil' only constrains to notification name, so value objects *can* be passed
            // in the notification itself.
            .sink { receivedNotification in
                print("passed through: ", receivedNotification)
                // receivedNotification.name
                // receivedNotification.object - object sending the notification (sometimes nil)
                // receivedNotification.userInfo - often nil
            }
    
        NotificationCenter.default.post(note)
    }
}
