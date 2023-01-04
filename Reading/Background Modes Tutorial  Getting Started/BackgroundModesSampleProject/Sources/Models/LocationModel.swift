/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Combine
import CoreLocation
import MapKit

extension LocationView {
  class Model: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var isLocationTrackingEnabled = false
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
      span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Published var pins: [PinLocation] = []

    let mgr: CLLocationManager

    override init() {
      mgr = CLLocationManager()
      mgr.desiredAccuracy = kCLLocationAccuracyBest
      // ✅ 这两行支持了后台定位更新
      mgr.requestAlwaysAuthorization()
      mgr.allowsBackgroundLocationUpdates = true

      super.init()
      mgr.delegate = self
    }

    func enable() {
      mgr.startUpdatingLocation()
    }

    func disable() {
      mgr.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      if let currentLocation = locations.first {
        print(currentLocation)
        location = currentLocation
        appendPin(location: currentLocation)
        updateRegion(location: currentLocation)
      }
    }

    func appendPin(location: CLLocation) {
      pins.append(PinLocation(coordinate: location.coordinate))
    }

    func updateRegion(location: CLLocation) {
      region = MKCoordinateRegion(
        center: location.coordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
    }

    func startStopLocationTracking() {
      isLocationTrackingEnabled.toggle()
      if isLocationTrackingEnabled {
        enable()
      } else {
        disable()
      }
    }
  }

  struct PinLocation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
  }
}
