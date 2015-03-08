

import UIKit
import MapKit
import CoreLocation

class LocationPeekViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    
	var mapview:MKMapView!
	var lManager:CLLocationManager!
	var infoView:InfoView!
	var locations:[CLLocation]! = nil
	var curLocation:Int = 0
	var t1:NSTimer!
	var t2:NSTimer!
	var intervalTimer:NSTimer!
	var interCount:CLLocationDegrees!
    
    var zoomlevel : Double = 0.025
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		if let locs = ((UIApplication.sharedApplication()).delegate as AppDelegate).locationData.mutableCopy() as? [CLLocation] {
			locations = locs.reverse();

		}
		
		//[ CLLocation(latitude: 41, longitude: -90.02), CLLocation(latitude: 41, longitude: -90.03), CLLocation(latitude: 41.01, longitude: -90.04),CLLocation(latitude: 41.02, longitude: -90.05),CLLocation(latitude: 41.003, longitude: -90.05),CLLocation(latitude: 41.06, longitude: -90.06),CLLocation(latitude: 41.07, longitude: -90.07)]
		
		//Location Manager setup
		lManager = CLLocationManager()
		lManager.delegate = self
		lManager.desiredAccuracy = kCLLocationAccuracyBest
		lManager.requestWhenInUseAuthorization()
		lManager.requestAlwaysAuthorization()
		lManager.startUpdatingLocation()
		
		mapview = MKMapView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
		mapview.showsUserLocation = false
		//mapview.setUserTrackingMode(MKUserTrackingMode.Follow, animated: false)
		mapview.zoomEnabled = false;
		mapview.scrollEnabled =  false;
		mapview.rotateEnabled = false;
		mapview.delegate=self;
		view .addSubview(mapview)
		
		
		t1 = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("drawNextPathPoint"), userInfo: nil, repeats: true)
		t2 = NSTimer.scheduledTimerWithTimeInterval(13, target: self, selector: Selector("viewTimeout"), userInfo: nil, repeats: false)
		
		
		
		//drop pin
		// Create your coordinate
		//	CLLocationCoordinate2D myCoordinate = {2, 2};
		//Create your annotation
		//	MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
		var point = MKPointAnnotation()
		// Set your annotation to point at your coordinate
		point.coordinate = locations[0].coordinate;
		//If you want to clear other pins/annotations this is how to do it
		for annotation in self.mapview.annotations {
			self.mapview.removeAnnotation(annotation as MKAnnotation);
		}
		//Drop pin on map
		self.mapview.addAnnotation(point)
		
		
		//deal with path
		
		
		let spanX = zoomlevel
		let spanY = zoomlevel
		var newRegion = MKCoordinateRegion(center: locations[0].coordinate, span: MKCoordinateSpanMake(spanX, spanY))
		mapview.setRegion(newRegion, animated: true)
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		
	}
	
	func drawNextPathPoint() {
		println("out")
		if (locations.count > curLocation + 1){
			if (intervalTimer != nil){ intervalTimer.invalidate()}
			println("in")
			curLocation++
			
			interCount = 0
			intervalTimer=NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("drawNextIntervalPathPoint"), userInfo: nil, repeats: true)
			
		}
		else{
			t1.invalidate()
			intervalTimer.invalidate()
		}
		
	}
	
	func viewTimeout(){
		self .dismissViewControllerAnimated(true, completion: nil)

	}
	
	func drawNextIntervalPathPoint(){
		println("in")
		
		if (interCount > 2.0){
			var latE = locations[locations.count - 1].coordinate.latitude
			var lngE = locations[locations.count - 1 ].coordinate.longitude
			
			var lat1 = locations[curLocation - 1].coordinate.latitude
			var lat2 = locations[curLocation].coordinate.latitude
			var dlat = ((lat2 - lat1)/1.0) as CLLocationDegrees
			
			var lng1 = locations[curLocation - 1].coordinate.longitude
			var lng2 = locations[curLocation ].coordinate.longitude
			var dlng = (lng2 - lng1)/1.0 as CLLocationDegrees
			
			var p1lat = ((interCount  ) * dlat )  + lat1
			var p1lng =  ((interCount )  * dlng + lng1)
			
			
			var a = [locations[curLocation-1].coordinate,locations[curLocation].coordinate]
			var point = MKPointAnnotation()
			// Set your annotation to point at your coordinate
			point.coordinate =	locations[curLocation].coordinate
			//If you want to clear other pins/annotations this is how to do it
			for annotation in self.mapview.annotations {
				self.mapview.removeAnnotation(annotation as MKAnnotation);
			}
			//Drop pin on map
			self.mapview.addAnnotation(point)
			
			
			//deal with path
			
			
			let spanX = zoomlevel
			let spanY = zoomlevel
			var newRegion = MKCoordinateRegion(center: locations[curLocation].coordinate, span: MKCoordinateSpanMake(spanX, spanY))
			mapview.setRegion(newRegion, animated: true)
			
			var polyline = MKPolyline(coordinates: &a, count: a.count)
			mapview.addOverlay(polyline)
			interCount = interCount + 1.0
			
			
			
			
			intervalTimer.invalidate()
			
		}
		var lat1 = locations[curLocation - 1].coordinate.latitude
		var lat2 = locations[curLocation ].coordinate.latitude
		var dlat = ((lat2 - lat1)/1.0) as CLLocationDegrees
		
		var lng1 = locations[curLocation - 1].coordinate.longitude
		var lng2 = locations[curLocation ].coordinate.longitude
		var dlng = (lng2 - lng1)/1.0 as CLLocationDegrees
		
		var p1lat = ((interCount  ) * dlat )  + lat1
		var p1lng =  ((interCount )  * dlng + lng1)
		
		
		var a = [CLLocationCoordinate2DMake(p1lat, p1lng), CLLocationCoordinate2DMake(p1lat + dlat, p1lng + dlng )]
		var point = MKPointAnnotation()
		// Set your annotation to point at your coordinate
		point.coordinate = CLLocationCoordinate2DMake(p1lat + dlat, p1lng + dlng )
		//If you want to clear other pins/annotations this is how to do it
		for annotation in self.mapview.annotations {
			self.mapview.removeAnnotation(annotation as MKAnnotation);
		}
		//Drop pin on map
		self.mapview.addAnnotation(point)
		
		
		//deal with path
		
		
		let spanX = zoomlevel
		let spanY = zoomlevel
		var newRegion = MKCoordinateRegion(center: CLLocationCoordinate2DMake(p1lat + dlat, p1lng + dlng ), span: MKCoordinateSpanMake(spanX, spanY))
		mapview.setRegion(newRegion, animated: true)
		
		var polyline = MKPolyline(coordinates: &a, count: a.count)
		mapview.addOverlay(polyline)
		interCount = interCount + 1.0
		
		intervalTimer.invalidate()
		
		
	}
	
 func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
	if overlay is MKPolyline {
		var polylineRenderer = MKPolylineRenderer(overlay: overlay)
		polylineRenderer.strokeColor = UIColor.greenColor()
		polylineRenderer.lineWidth = 3
		return polylineRenderer
	}
	return nil
	}
}

