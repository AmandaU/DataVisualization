//
//  DataVisualizationViewController.swift
//  DataVisualization
//
//  Created by Amanda Baret on 2020/05/24.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import UIKit
import MapKit

class DataVisualizationViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var mapView: MKMapView!
    
    private lazy var viewModel = DataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressView.progress = 0.0
        
        viewModel.downloadfile(progress: { (prog) in
            self.progressView.progress = Float(prog)
        }) { (model, error) in
                         DispatchQueue.main.async {
                            if((error) != nil){
                                self.showAlert(title: "Oops", message: error?.localizedDescription ?? "")
                        }else {
                                   self.viewModel.gadgets!.forEach {
                                       self.addGadgetsToMap(gadget: $0)
                                       }
                            }
                        
                }
        }
          
    }
    
    private  func addGadgetsToMap(gadget: Gadget) {
        // Show artwork on map
        let gadget = GadgetAnnotation(
            title: gadget.title,
            coordinate: CLLocationCoordinate2D(latitude: gadget.latitude, longitude: gadget.longitude),
            locationName: "")
        mapView.addAnnotation(gadget)
    }
}


extension DataVisualizationViewController: MKMapViewDelegate {
    // 1
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? GadgetAnnotation else {
            return nil
        }
        // 3
        let identifier = "gadget"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
            view.canShowCallout = false
            view.calloutOffset = CGPoint(x: -5, y: 5)
            //view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
