//
//  LocationHeadingProxy.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/14.
//

import UIKit
import Combine
import CoreLocation
//通过包装基于 delegate 的 API 创建重复发布者
//Future 发布者非常适合包装现有代码以发出单个请求，但它不适用于产生冗长或可能无限量输出的发布者。
final class LocationHeadingProxy: NSObject,CLLocationManagerDelegate {
    let mgr: CLLocationManager
    private let headingPublisher: PassthroughSubject<CLHeading, Error>
    var publisher: AnyPublisher<CLHeading, Error>
    
    override init() {
        mgr = CLLocationManager()
        headingPublisher = PassthroughSubject<CLHeading, Error>()
        publisher = headingPublisher.eraseToAnyPublisher()

        super.init()
        mgr.delegate = self
    }

    func enable() {
        mgr.startUpdatingHeading()
    }

    func disable() {
        mgr.stopUpdatingHeading()
    }
    // MARK - delegate methods

    /*
     *  locationManager:didUpdateHeading:
     *
     *  Discussion:
     *    Invoked when a new heading is available.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        headingPublisher.send(newHeading)
    }

    /*
     *  locationManager:didFailWithError:
     *  Discussion:
     *    Invoked when an error has occurred. Error types are defined in "CLError.h".
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        headingPublisher.send(completion: Subscribers.Completion.failure(error))
    }
}
