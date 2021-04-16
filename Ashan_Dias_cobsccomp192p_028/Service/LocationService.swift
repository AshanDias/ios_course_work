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
    
    init(manager: CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        
        manager.delegate = self
        manager.distanceFilter = kCLDistanceFilterNone
              manager.requestAlwaysAuthorization()
              manager.startUpdatingLocation()
        
                manager.stopUpdatingLocation()
    
    }
 
    
    var newLocation: ((Result<CLLocation>) -> Void)?
    var didChangeStatus: ((Bool) -> Void)?
    
//    var status: CLAuthorizationStatus {
//        return CLLocationManager.authorizationStatus()
//    }
    
    func calculateDistance(lt:Double,lat:Double) -> Int {
     
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()

        let longt = Double((manager.location?.coordinate.longitude)!)
        let lattude = Double((manager.location?.coordinate.latitude)!)
        
//        let longt1 = Double(37.59452644)
//        let lattude1 = Double(-122.41234263)
        
        
        let coordinate1 = CLLocation(latitude: lat, longitude: lt)
        let coordinate2 = CLLocation(latitude: lattude, longitude:longt)
        let distanceInMeters = coordinate2.distance(from: coordinate1)/1000
        
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
