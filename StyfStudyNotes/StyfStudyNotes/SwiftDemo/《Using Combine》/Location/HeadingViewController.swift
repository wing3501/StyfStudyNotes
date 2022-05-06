//
//  HeadingViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/14.
//

import UIKit
import Combine
import CoreLocation

class HeadingViewController: UIViewController {

    var headingSubscriber: AnyCancellable?

    let coreLocationProxy = LocationHeadingProxy()
    var headingBackgroundQueue: DispatchQueue = DispatchQueue(label: "headingBackgroundQueue")
    
    lazy var permissionButton: UIButton = {
        var v = UIButton(type: .custom)
        v.backgroundColor = .green
        v.setTitle("按钮", for: .normal)
        v.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        v.addTarget(self, action: #selector(requestPermission), for: .touchUpInside)
        return v
    }()
    
    @objc func requestPermission(_ sender: UIButton) {
        print("requesting corelocation permission")
        let _ = Future<Int, Never> { promise in
            self.coreLocationProxy.mgr.requestWhenInUseAuthorization()
            return promise(.success(1))
        }
        .delay(for: 2.0, scheduler: headingBackgroundQueue)
        .receive(on: RunLoop.main)
        .sink { _ in
            print("updating corelocation permission label")
            self.updatePermissionStatus()
        }
    }
    
    func updatePermissionStatus() {
        let x = CLLocationManager.authorizationStatus()
        switch x {
        case .authorizedWhenInUse:
            locationPermissionLabel.text = "Allowed when in use"
        case .notDetermined:
            locationPermissionLabel.text = "notDetermined"
        case .restricted:
            locationPermissionLabel.text = "restricted"
        case .denied:
            locationPermissionLabel.text = "denied"
        case .authorizedAlways:
            locationPermissionLabel.text = "authorizedAlways"
        @unknown default:
            locationPermissionLabel.text = "unknown default"
        }
    }
    
    lazy var activateTrackingSwitch: UISwitch = {
        var v = UISwitch(frame: CGRect(x: 50, y: 160, width: 100, height: 40))
        v.backgroundColor = .yellow
        v.addTarget(self, action: #selector(trackingToggled), for: .valueChanged)
        return v
    }()
    
    @objc func trackingToggled(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            self.coreLocationProxy.enable()
            print("Enabling heading tracking")
        case false:
            self.coreLocationProxy.disable()
            print("Disabling heading tracking")
        }
    }
    
    lazy var headingLabel: UILabel = {
        var v = UILabel(frame: CGRect(x: 50, y: 210, width: 300, height: 50))
        v.textColor = .black
        v.backgroundColor = .orange
        return v
    }()
    
    lazy var locationPermissionLabel: UILabel = {
        var v = UILabel(frame: CGRect(x: 50, y: 270, width: 300, height: 50))
        v.textColor = .black
        v.backgroundColor = .orange
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(permissionButton)
        view.addSubview(activateTrackingSwitch)
        view.addSubview(headingLabel)
        view.addSubview(locationPermissionLabel)
        
        self.updatePermissionStatus()

        let corelocationsub = coreLocationProxy
            .publisher
            .print("headingSubscriber")
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err)
                }
            } receiveValue: { someValue in
                self.headingLabel.text = String(someValue.trueHeading)
            }

        headingSubscriber = AnyCancellable(corelocationsub)
    }

}
