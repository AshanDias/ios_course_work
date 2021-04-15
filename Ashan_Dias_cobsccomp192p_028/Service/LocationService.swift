//
//  LocationService.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-15.
//

import Foundation



import CoreLocation

enum Result<T> {
    case success(T)
    case failure(Error)
}

final class LocationService: NSObject {
    private let manager: CLLocationManager
    private let location = CLLocation.init()
    init(manager: CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        
        manager.delegate = self
        manager.startUpdatingLocation()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.stopUpdatingLocation()     // request will restart it
       // manager.allowsBackgroundLocationUpdates = true
    }
 
    
    var newLocation: ((Result<CLLocation>) -> Void)?
    var didChangeStatus: ((Bool) -> Void)?
    
    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func calculateDistance(lt:Double,lat:Double) -> Int {

//        37.785834000000001
//        -122.406417
       
        var lat1 = (manager.location?.coordinate.latitude)!
        var logt1 = (manager.location?.coordinate.longitude)!
        
        let coordinate1 = CLLocation(latitude: lat, longitude: lt)
        let coordinate2 = CLLocation(latitude: lat1, longitude:logt1)
        let distanceInMeters = coordinate2.distance(from: coordinate1)
        
        return Int(distanceInMeters)
    }
    
    func requestLocationAuthrization() {
        
        manager.requestAlwaysAuthorization()
      
    }
    
    func getLocation() {
       
        self.manager.requestAlwaysAuthorization()

          // For use in foreground
          self.manager.requestAlwaysAuthorization()

          if CLLocationManager.locationServicesEnabled() {
            print("Request location update")
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
          }
    
        
      //  manager.requestLocation()
    }
    
    func checkIfLocationIsEnbled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
         return true
        }else{
            return false
        }
    }
    
    func isLocationAccessEnabled() {
       if CLLocationManager.locationServicesEnabled() {
      
          switch CLLocationManager.authorizationStatus() {
          case .notDetermined, .restricted, .denied  : do {
            requestLocationAuthrization()
          
            print("No access")
            break
                  }
          case .authorizedAlways, .authorizedWhenInUse:do {
            print("Access")
            break
          }
               
          }
       } else {
          print("Location services not enabled")
       }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        newLocation?(.failure(error))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
            newLocation?(.success(location))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            didChangeStatus?(false)
        default:
            didChangeStatus?(true)
        }
    }
}
