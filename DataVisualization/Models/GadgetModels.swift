//
//  GadgetModels.swift
//  DataVisualization
//
//  Created by Amanda Baret on 2020/05/24.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class GadgetAnnotation: NSObject, MKAnnotation {

  let title: String?
  let coordinate: CLLocationCoordinate2D
  let locationName: String?

  init(
    title: String?,
    coordinate: CLLocationCoordinate2D,
    locationName: String?
  ) {
    self.locationName = locationName
    self.coordinate = coordinate
    self.title = title
    super.init()
  }
}

struct Gadget: Codable {
    
    var title: String = ""
    var latitude = 0.0
    var longitude = 0.0
    var speed = ""
    var time = ""
}

struct GadgetModel: Codable {
    var gadgets: [Gadget]!
}
