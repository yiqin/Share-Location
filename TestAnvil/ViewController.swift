//
//  ViewController.m
//  TestAnvil
//
//  Created by Yi Qin on 3/6/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let myLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        myLocationManager.delegate = self;
        myLocationManager.pausesLocationUpdatesAutomatically = true
        myLocationManager.activityType = CLActivityType.AutomotiveNavigation
        
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.NotDetermined {
            println("send the request.....")
            
            myLocationManager.requestAlwaysAuthorization()
        }
        
        myLocationManager.startUpdatingLocation()
        myLocationManager.requestWhenInUseAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            if status == CLAuthorizationStatus.Authorized || status == CLAuthorizationStatus.AuthorizedWhenInUse {
                manager.startUpdatingLocation()
                // ...
            }
    }
    
    
    //CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[locations.count-1] as CLLocation
        
        println("locations = \(locations)")
        
        // Post HTTTP request....
        
        var object = PFObject(className: "test")
        object["title"] = "this is a test."
        object.saveInBackgroundWithBlock { (success:Bool!, error:NSError!) -> Void in
            println("save this is a test.")
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
        
    }
    
    
    
}

