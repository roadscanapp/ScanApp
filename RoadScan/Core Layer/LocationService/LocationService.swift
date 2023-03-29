//
//  LocationService\.swift
//  InRoad
//
//  Created by Dinmukhamed on 20.03.2023.
//

import CoreLocation

struct CurrentLocationModel {
    var lat: Double
    var lon: Double
}

protocol LocationServiceProtocol {
    func getCurrentLocation(with location: CurrentLocationModel)
}

final class LocationService: NSObject {
    var locationManager: CLLocationManager = CLLocationManager()
    
    var delegate: LocationServiceProtocol?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopMonitoringSignificantLocationChanges()
        let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locationValue)")
        
        delegate?.getCurrentLocation(with: .init(lat: locationValue.latitude, lon: locationValue.longitude))
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
}