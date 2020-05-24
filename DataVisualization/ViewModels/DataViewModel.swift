//
//  DataViewModel.swift
//  DataVisualization
//
//  Created by Amanda Baret on 2020/05/24.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation
import AWSS3

class DataViewModel {
   
    var gadgets: [Gadget]?
    
//    public func FetchData(success:  @escaping (Bool)->(), failure:  @escaping (String)->(),
//                          progress: @escaping (Float)->()){
//        service.FetchData(success: { (model) in
//            self.gadgets = model.gadgets
//            success(true)
//        }) { (error) in
//             failure(error)
//        }
//    }
    
     func downloadfile(progress: progressBlock?, completion: completionBlock?) {
   
              let url = "https://s3-us-west-2.amazonaws.com/discovery-insure-interview/sightings_alerts.zip"

        AWSS3Manager.shared.downloadfile(fileName: "sightings_alerts.zip", progress: progress, completion: completion)
           }
      }
      

