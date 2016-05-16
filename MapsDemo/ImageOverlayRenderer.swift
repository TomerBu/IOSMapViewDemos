//
//  ImageOverlayRenderer.swift
//  MapsDemo
//
//  Created by Tomer Buzaglo on 16/05/2016.
//  Copyright © 2016 iTomerBu. All rights reserved.
//

import UIKit
import MapKit

class ImageOverlayRenderer: MKOverlayRenderer {
    var overlayImage: UIImage
    
    init(overlay:MKOverlay, overlayImage:UIImage) {
        self.overlayImage = overlayImage
        super.init(overlay: overlay)
    }
    
    override func drawMapRect(mapRect: MKMapRect,
                              zoomScale: MKZoomScale, inContext context: CGContext) {
        
        let mapRect = overlay.boundingMapRect
        let rect = rectForMapRect(mapRect) //we need a CGRegt
        
        UIGraphicsPushContext(context)
        overlayImage.drawInRect(rect)
        UIGraphicsPopContext()
    }
}