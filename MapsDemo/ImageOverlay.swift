//
//  ImageOverlay.swift
//  MapsDemo
//
//  Created by Tomer Buzaglo on 16/05/2016.
//  Copyright © 2016 iTomerBu. All rights reserved.
//

import UIKit
import MapKit

class ImageOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    var identifier:String?
    
    init(geo: ImageOverlayGeoData) {
        boundingMapRect = geo.overlayBoundingMapRect
        coordinate = geo.midPointCoordinates
    }
}


import UIKit
import MapKit

class ImageOverlayGeoData {
    //MARK: Overlay Properties
    let topLeftCoordinates:CLLocationCoordinate2D
    let topRightCoordinates:CLLocationCoordinate2D
    let bottomLeftCoordinates:CLLocationCoordinate2D
    let midPointCoordinates:CLLocationCoordinate2D
    var identifier: String?
    
    //MARK: initializers
    //demo initializer with demo data
    init(){
        topLeftCoordinates = CLLocationCoordinate2DMake(
            34.4311,-118.6012)
        topRightCoordinates = CLLocationCoordinate2DMake(
            34.4311,-118.5912)
        bottomLeftCoordinates = CLLocationCoordinate2DMake(
            34.4194,-118.6012)
        midPointCoordinates = CLLocationCoordinate2DMake(
            34.4248,-118.5971)
    }
    
    init(topLeft:CLLocationCoordinate2D, topRight:CLLocationCoordinate2D, bottomLeft:CLLocationCoordinate2D, center:CLLocationCoordinate2D){
        self.topLeftCoordinates = topLeft
        self.topRightCoordinates = topRight
        self.bottomLeftCoordinates = bottomLeft
        self.midPointCoordinates = center
    }
    
    //MARK: Computed properties
    var topRight:MKMapPoint{
        return MKMapPointForCoordinate(topRightCoordinates)
    }
    
    var region:MKCoordinateRegion{
        let latDelta =  topLeftCoordinates.latitude -
            bottomLeftCoordinates.latitude
        let lonDelta =  topRightCoordinates.longitude -
            topLeftCoordinates.longitude
        // A span as is a latLon related rectangle
        // width and height (diff lat & lon)
        let span = MKCoordinateSpanMake(
            fabs(latDelta),
            fabs(lonDelta)
        )
        
        let region = MKCoordinateRegionMake(
            midPointCoordinates, span)
        return region
    }
    
    var topLeft:MKMapPoint{
        return MKMapPointForCoordinate(topLeftCoordinates)
    }
    var bottomLeft:MKMapPoint{
        return MKMapPointForCoordinate(bottomLeftCoordinates)
    }
    
    //Bottom is a computed property using the 3 other point
    var bottomRightCoordinates: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(bottomLeftCoordinates.latitude,
                                              topRightCoordinates.longitude)
        }
    }
    
    var width:Double{
        return fabs(topLeft.x - topRight.x)
    }
    
    var height:Double{
        return fabs(topLeft.y - bottomLeft.y)
    }
    
    var overlayBoundingMapRect: MKMapRect {
        get {
            let rectOrigin = topLeft
            return MKMapRectMake(
                rectOrigin.x, rectOrigin.y, width, height
            )
        }
    }
}
