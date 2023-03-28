//
//  GoogleMapsService.swift
//  RoadScan
//
//  Created by Ernar Khasen on 29.03.2023.
//

import Foundation
import GoogleMaps

protocol GoogleMapsServiceDeligate {
    func getMyCameraPosition(mapView: GMSMapView) -> GMSCameraPosition
    func getZoomInValue(mapView: GMSMapView) -> Float
    func getZoomOutValue(mapView: GMSMapView) -> Float
}

final class GoogleMapsService: GoogleMapsServiceDeligate {
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
