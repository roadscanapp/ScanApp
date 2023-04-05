import UIKit
import GoogleMaps

protocol GoogleMapsServiceDeligate {
    func setupMapView(view: UIView) -> GMSMapView
    func getMyCameraPosition(mapView: GMSMapView) -> GMSCameraPosition
    func getZoomInValue(mapView: GMSMapView) -> Float
    func getZoomOutValue(mapView: GMSMapView) -> Float
}

final class GoogleMapsService: GoogleMapsServiceDeligate {
    func setupMapView(view: UIView) -> GMSMapView {
        var mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: 0.0,
                                              longitude:   0.0,
                                              zoom:         0)
        
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        
        return mapView
    }
    
    func getMyCameraPosition(mapView: GMSMapView) -> GMSCameraPosition {
        guard
            let lat = mapView.myLocation?.coordinate.latitude,
            let lng = mapView.myLocation?.coordinate.longitude
        else { return GMSCameraPosition() }

        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 15)
        
        return camera
    }
    
    func getZoomInValue(mapView: GMSMapView) -> Float {
        let zoomInValue = mapView.camera.zoom + 1
        return zoomInValue
    }
    
    func getZoomOutValue(mapView: GMSMapView) -> Float {
        let zoomOutValue = mapView.camera.zoom - 1
        return zoomOutValue
    }
}
