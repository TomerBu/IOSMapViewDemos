//
//  ViewController.swift
//  MapsDemo
//
//  Created by Tomer Buzaglo on 16/05/2016.
//  Copyright © 2016 iTomerBu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController:MKMapViewDelegate{
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        addParkImageOverlay()
        let park = ImageOverlayGeoData()
        mapView.setCenterCoordinate(park.midPointCoordinates, animated: true)
    }
    func addParkImageOverlay(){
        let park = ImageOverlayGeoData()
        mapView.region = park.region
        let overlay = ImageOverlay(geo: park)
        overlay.identifier = "park"
        mapView.addOverlay(overlay)
    }
    func mapView(mapView: MKMapView,
                 rendererForOverlay overlay: MKOverlay)
        -> MKOverlayRenderer {
            if let overlay = overlay as? ImageOverlay
                where overlay.identifier == "park"{
                return  ImageOverlayRenderer(overlay: overlay,
                                             overlayImage: UIImage(named:"overlay_park")!)
            }
            return MKPolylineRenderer(overlay: overlay)
    }
}

extension ViewController:CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
}