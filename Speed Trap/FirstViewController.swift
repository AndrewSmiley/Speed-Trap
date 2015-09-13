//
//  FirstViewController.swift
//  Speed Trap
//
//  Created by Andrew Smiley on 9/10/15.
//  Copyright (c) 2015 Andrew Smiley. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    @IBOutlet var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    let label = UILabel(frame: CGRectMake(0, 0, 200, 35) )
    let googleAPIRequestor = GoogleAPIRequestor()
    var currentLocation: CLLocation = CLLocation()
    var didFindMyLocation = false
//    let speedManager = CLLocationSpeed();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
//        self.mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        self.mapView.camera = camera
        self.mapView.delegate = self
        locationManager.delegate = self
        mapView.myLocationEnabled = true
        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        label.font = UIFont(name: label.font.fontName, size: 32)
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = "0 mph"
        self.view.addSubview(label)
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
//            mapView.myLocationEnabled = true
        }
    }
    // 5
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        if let location = locations.first as? CLLocation {
//            println("Updated Location")
////            currentLocation = location
////            // 6
////
//////            pri
//////            mapView.
//////            mapView.myLocation.coordinate = location.coordinate
////            
////            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 30, bearing: 0, viewingAngle: 0)
////            self.mapView.animateToLocation(location: location)
//            mapView.animateToLocation(location.coordinate)
////            self.mapView.myLocationEnabled = true
////            self.mapView.
//            label.text = String(stringInterpolationSegment: Int(location.speed*2.23693629))+"mph"
//            // 7
////            locationManager.stopUpdatingLocation()
//        }
//    }

    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        reverseGeocodeCoordinate(position.target)
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                
                // 3
//                let lines = address.lines as! [String]
//                self.addressLabel.text = join("\n", lines)
                
                // 4
                UIView.animateWithDuration(0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        println("We hit the funky function")
//        if didFindMyLocation {
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            var camera = GMSCameraPosition.cameraWithLatitude(myLocation.coordinate.latitude,
            longitude: myLocation.coordinate.longitude, zoom: 15)
        
            mapView.camera = camera
            println(String(stringInterpolationSegment: mapView.myLocation.coordinate.longitude)+","+String(stringInterpolationSegment: mapView.myLocation.coordinate.latitude))
            mapView.settings.myLocationButton = true
            label.text = String(stringInterpolationSegment: Int(myLocation.speed*2.23693629))+" mph"
        googleAPIRequestor.getSpeedLimit(String(stringInterpolationSegment: myLocation.coordinate.longitude), latitude: String(stringInterpolationSegment: myLocation.coordinate.latitude), withCompletionHandler: {(status: String, success: Bool, speed: String) -> Void in

            
        })
//            didFindMyLocation = true
//        }
    }
}

