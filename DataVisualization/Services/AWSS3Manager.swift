//
//  AWSS3Manager.swift
//  DataVisualization
//
//  Created by Amanda Baret on 2020/05/24.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation

import UIKit
import AWSS3

typealias progressBlock = (_ progress: Double) -> Void
typealias completionBlock = (_ response: Any?, _ error: Error?) -> Void
typealias CompletionHandler = (_ success:Bool) -> Void

class AWSS3Manager {
    static let shared = AWSS3Manager()
    private init () { }
    let bucketName = "discovery-insure-interview"
    
    //MARK:- AWS file download
    
    // Download single file from AWS S3 single bucket
    //    func downloadSingleFileFromAWS(fileName: String, progress: progressBlock?, completion: completionBlock?) {
    //        self.downloadfile(fileName: fileName, progress: progress, completion: completion)
    //    }
    
    // Download all files from AWS S3 single bucket
    func downloadAllFilesFromAWSBucket(progress: progressBlock?, completion: completionBlock?) {
        let s3 = AWSS3.default()
        let listRequest: AWSS3ListObjectsRequest = AWSS3ListObjectsRequest()
        listRequest.bucket = bucketName
        var allFiles = [String]()
        s3.listObjects(listRequest).continueWith { (task) -> AnyObject? in
            if let error = task.error {
                print("Error occurred: \(error)")
                return nil
            }
            if ((task.result?.contents) != nil){
                for object in (task.result?.contents)! {
                    // print(“Object key = \(object.key!)”)
                    allFiles.append(object.key!)
                }
            }
            if let completionBlock = completion {
                completionBlock(allFiles, nil)
            }
            return nil
        }
    }
    
    func downloadfile(fileName: String,progress: progressBlock?, completion: completionBlock?) {
    // Download progress block
    let expression = AWSS3TransferUtilityDownloadExpression()
        expression.progressBlock = {(task, awsProgress) in
        guard let downloadProgress = progress else { return }
        DispatchQueue.main.async {
        downloadProgress(awsProgress.fractionCompleted)
        }
    }
    // Completion block
    var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
        completionHandler = {(task, location, data, error) -> Void in
        DispatchQueue.main.async(execute: {
        if ((error) != nil){
        //NSLog(“Failed with error”)
        print("Error: %@",error!);
        if let completionBlock = completion {
        completionBlock(nil, error)
        }
    }
    else{
        print("Success");
        print(data as Any)
        if let completionBlock = completion {
        completionBlock(data, nil)
        }
        }
    })
    }
    // Start downloading using AWSS3TransferUtility
    let awsTransferUtility = AWSS3TransferUtility.default()
        awsTransferUtility.downloadData(fromBucket: bucketName, key: fileName, expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
        if let error = task.error {
        print("Error: %@",error.localizedDescription);
    }
    if let _ = task.result {
    //print(“Download Starting!”)
    }
        return nil;
    }
    }

    
}
