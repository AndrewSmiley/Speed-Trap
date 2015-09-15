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
    let baseSpeedLimitURL = "http://route.st.nlp.nokia.com/routing/6.2/getlinkinfo.json?"
    var lookupSpeedLimitResults: Dictionary<NSObject, AnyObject>!
    
    func getSpeedLimit(longitude: String!, latitude: String!, withCompletionHandler completionHandler: ((status: String, success: Bool, speed: String) -> Void)) {
        var speedLimitURLString = baseSpeedLimitURL+"waypoint="+latitude+","+longitude+"&app_id=DemoAppId01082013GAL&app_code=AJKnXv84fjrb0KIHawS0Tg"
        speedLimitURLString = speedLimitURLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let speedLimitURL = NSURL(string: speedLimitURLString)
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
        let speedLimitResultsData:NSData = NSData(contentsOfURL: speedLimitURL!)!
            
            var error: NSError?
            let dictionary: Dictionary<NSObject, AnyObject> = NSJSONSerialization.JSONObjectWithData(speedLimitResultsData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! Dictionary<NSObject, AnyObject>
//        let json = JSON(data: speedLimitResultsData)
        var parseError: NSError?
        let JSONObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(speedLimitResultsData, options: NSJSONReadingOptions.AllowFragments, error: &parseError)
        
        
//        if let statusesArray = JSONObject as? [AnyObject],
//            let status = statusesArray[0] as? [String: AnyObject],
//            let user = status["user"] as? [String: AnyObject],
//            let username = user["name"] as? String {
                // Finally we got the username
//        }
            if (error != nil) {
                println(error)
                completionHandler(status: "", success: false, speed: "")
            }else{
                let duck: NSDictionary = (JSONObject as? NSDictionary)!
                let goose: NSDictionary = (duck["Response"] as? NSDictionary)!
                let pigeon: NSArray = (goose["Link"] as? NSArray)!
                let snipe: NSDictionary = (pigeon[0] as? NSDictionary)!
                let swallow: NSDictionary = (snipe["DynamicSpeedInfo"] as? NSDictionary)!
                let roadRunner: NSNumber = (swallow["BaseSpeed"] as? NSNumber)!
                completionHandler(status: "OK", success: true, speed: roadRunner.stringValue)

                
            }
//        })
        
    }
    
//    func getValue(key: String, value: AnyObject)->AnyObject{
//        return value[
//    }
    
    
    
}