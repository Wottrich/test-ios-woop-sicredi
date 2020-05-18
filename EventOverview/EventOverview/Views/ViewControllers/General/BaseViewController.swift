//
//  ViewController.swift
//  EventOverview
//
//  Created by Wottrich on 16/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import MapKit
import NetunoNavigation

class BaseViewController: UIViewController {

    lazy var navigate: Navigator = {
        return mNavigate ?? Navigator(navigationController: self.navigationController)
    }()
    
    private var mNavigate: Navigator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mNavigate = Navigator(navigationController: self.navigationController)
        
    }

    func alert(title: String = "Atenção", error message: String,
               button: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alert(
        title: String = "Atenção",
        message: String,
        style: UIAlertController.Style = .actionSheet,
        handlers: [UIAlertAction]
    ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action in handlers {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }

    func openGoogleMap (latitude: NSNumber, longitude: NSNumber) {
        
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving") {
            UIApplication.shared.open(url)
        }
        
    }
    
    func openAppleMap (title: String, latitude: NSNumber, longitude: NSNumber) {
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(CLLocationDegrees(truncating: latitude), CLLocationDegrees(truncating: longitude))
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        mapItem.openInMaps(launchOptions: options)
        
    }
    
}

