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

class MainViewController: UIViewController, LeftViewControllerDelegate, MKMapViewDelegate {

    var mapview:MKMapView!
    var lManager:CLLocationManager!
    var infoView:InfoView!
    var leadingBoardScrollView : JT3DScrollView!
	var timer:NSTimer!;
	var mkan:MKAnnotationView!;
    
    
    // A lot of CLLocation-s
    var userPathDataArray : NSMutableArray = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        let xPadding : CGFloat = 10.0
        let yPadding : CGFloat = 10.0
        
        
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        leadingBoardScrollView = JT3DScrollView(frame: CGRectMake(xPadding, yPadding, CGRectGetWidth(self.view.frame)-2*xPadding, CGRectGetHeight(self.view.frame)-2*yPadding))
        leadingBoardScrollView.backgroundColor = UIColor.blackColor()
        
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
        
        mapview = MKMapView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-125))
        mapview.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        mapview.showsUserLocation = true
        mapview.setUserTrackingMode(MKUserTrackingMode.Follow, animated: false)
        mapview.zoomEnabled = false;
        mapview.scrollEnabled =  false;
        mapview.rotateEnabled = false;
		mapview.delegate = self;
        view.addSubview(mapview)
        
        infoView = InfoView(frame: CGRectMake(0, self.view.frame.height - 125, self.view.frame.width, 125))
        infoView.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        view.addSubview(infoView)
        
        
        let tempText = NSMutableAttributedString(string: "LOCASHION")
        tempText.addAttribute(NSFontAttributeName, value: UIFont(name: "OpenSans-Semibold", size: 17)!, range: NSMakeRange(0, tempText.length))
        tempText.addAttribute(NSForegroundColorAttributeName, value: UIColor(fromHexString: "3d5fc4"), range: NSMakeRange(0, 2))
        
        tempText.addAttribute(NSForegroundColorAttributeName, value: UIColor(fromHexString: "ffb745"), range: NSMakeRange(2, tempText.length-2))
        
        let tempWidth = UIScreen.mainScreen().bounds.size.width
        
        let tempLabel = TTTAttributedLabel(frame: CGRectMake(0, 0, tempWidth, 44))
        tempLabel.attributedText = tempText
        tempLabel.textAlignment = NSTextAlignment.Center
        
        navigationItem.titleView = tempLabel
    }
    
    override func viewWillAppear(animated: Bool) {
        
        var l = UIBarButtonItem(image: UIImage(named: "friends"), style: .Plain, target: self, action: "pressFriends")
        self.navigationItem.leftBarButtonItem = l
        
        if (PFUser.currentUser() != nil) {
            self.setRightNavigationItem()
        }
        else {
            var b = UIBarButtonItem(title: "Login", style: .Plain, target: self, action: "pressLogin")
            self.navigationItem.rightBarButtonItem = b
        }
    }
    
    func setRightNavigationItem() {
        var b = UIBarButtonItem(image: UIImage(named: "setting"), style: .Plain, target: self, action: "pressProfileSetting")
        self.navigationItem.rightBarButtonItem = b
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pressLogin() {
        PFFacebookUtils.logInWithPermissions(nil, {
            (user: PFUser!, error: NSError!) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                } else {
                    println("User logged in through Facebook!")
                    FacebookDataManager.loadData()
                    self.setRightNavigationItem()
                    
                    // We need to update something here....
                    
                }
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        })
    }
    
    func pressProfileSetting() {
        
        NSNotificationCenter.defaultCenter().postNotificationName("openRightViewController", object: nil)
        
    }
    
    func pressFriends() {
        
        NSNotificationCenter.defaultCenter().postNotificationName("openLeftViewController", object: nil)
        
    }

    func showLeadingBoardScrollView(index: Int) {
        
        
        view.addSubview(leadingBoardScrollView)
        
    }
    
    
    func updateUserPathDataArray(userPathDataArray:NSArray){
        
        println(userPathDataArray.count)
        
        
    }
	
	func mapView(mapView: MKMapView!, didAddAnnotationViews views: [AnyObject]!) {
		for  annotation in views {
			//if (annotation as NSObject == mapview.userLocation){
				mkan = annotation as MKAnnotationView
				timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("displayAnnotation"), userInfo: nil, repeats: false)
			//}
		}
	}
	func displayAnnotation(){
		mapview .selectAnnotation(mkan.annotation as MKAnnotation , animated: true)

	}
    
}
