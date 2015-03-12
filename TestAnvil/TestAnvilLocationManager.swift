//
//  TestAnvilLocationManager.swift
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit
import CoreLocation

class TestAnvilLocationManager: NSObject, CLLocationManagerDelegate{
    
    let myLocationManager = CLLocationManager()
    
    class var sharedInstance : TestAnvilLocationManager {
        struct Static {
            static let instance = TestAnvilLocationManager()
        }
        return Static.instance
    }
    
    func startLocationManager() {
        myLocationManager.delegate = self;
        myLocationManager.pausesLocationUpdatesAutomatically = false
        myLocationManager.activityType = CLActivityType.Fitness
        myLocationManager.distanceFilter = kCLDistanceFilterNone
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.NotDetermined {
            println("send the request.....")
            myLocationManager.requestAlwaysAuthorization()
        }
        
        myLocationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            if status == CLAuthorizationStatus.AuthorizedAlways || status == CLAuthorizationStatus.AuthorizedWhenInUse {
                manager.startUpdatingLocation()
                // ...
            }
    }
    
    //CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[locations.count-1] as CLLocation
        
        // println("locations = \(locations)")
        
        let currentGeoPoint = PFGeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        CurrentUserManager.sharedInstance.updateCurrentGeopoint(currentGeoPoint)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
        
    }
}
