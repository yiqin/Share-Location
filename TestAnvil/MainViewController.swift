//
//  MainViewController.swift
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {

    var mapview:MKMapView!
    var lManager:CLLocationManager!
    var infoView:InfoView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.whiteColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Location Manager setup
        lManager = CLLocationManager()
        lManager.desiredAccuracy = kCLLocationAccuracyBest
        lManager.requestWhenInUseAuthorization()
        lManager.requestAlwaysAuthorization()
        lManager.startUpdatingLocation()
        
        mapview = MKMapView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-100))
        mapview.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        mapview.showsUserLocation = true
        mapview.setUserTrackingMode(MKUserTrackingMode.Follow, animated: false)
        mapview.zoomEnabled = false;
        mapview.scrollEnabled =  false;
        mapview.rotateEnabled = false;
        view.addSubview(mapview)
        
        infoView = InfoView(frame: CGRectMake(0, self.view.frame.height - 100, self.view.frame.width, 100))
        infoView.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        view.addSubview(infoView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
