//
//  GoogleAPIRequestor.swift
//  Speed Trap
//
//  Created by Andrew Smiley on 9/13/15.
//  Copyright (c) 2015 Andrew Smiley. All rights reserved.
//

import Foundation
//import AppDelegate
class GoogleAPIRequestor {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let baseSpeedLimitURL = "https://roads.googleapis.com/v1/speedLimits?"
    var lookupSpeedLimitResults: Dictionary<NSObject, AnyObject>!
    
    func getSpeedLimit(longitude: String!, latitude: String!, withCompletionHandler completionHandler: ((status: String, success: Bool, speed: String) -> Void)) {
        var speedLimitURLString = baseSpeedLimitURL+"path="+latitude+"|"+longitude+"&key="+appDelegate.getGoogleMapsApiKey()
        speedLimitURLString = speedLimitURLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let speedLimitURL = NSURL(string: speedLimitURLString)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let speedLimitResultsData = NSData(contentsOfURL: speedLimitURL!)
            
            var error: NSError?
            let dictionary: Dictionary<NSObject, AnyObject> = NSJSONSerialization.JSONObjectWithData(speedLimitResultsData!, options: NSJSONReadingOptions.MutableContainers, error: &error) as! Dictionary<NSObject, AnyObject>
            if (error != nil) {
                println(error)
                completionHandler(status: "", success: false, speed: "")
            }else{
              let status = dictionary["status"] as! String
                
            }
        })
    }
    
}