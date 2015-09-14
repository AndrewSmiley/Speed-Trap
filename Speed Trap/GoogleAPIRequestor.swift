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
        let JSONObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(speedLimitResultsData, options: nil, error: nil)
        
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
//                
                let allResults = dictionary["Response"] as! Array<Dictionary<String, AnyObject>>
                let moreShit = allResults[1] as! Array<Dictionary<String, AnyObject>>
                println("Fuck you")
//                let speed = moreShit[
//                if let info = JSONObject as? [AnyObject],
//                    let response = info[0] as? [String:AnyObject],
//                    let link:Dictionary = response["Link"] as? [String:AnyObject],
//                    let dynamicSpeedInfo:Dictionary = link["DynamicSpeedInfo"] as? [String:AnyObject],
//                    let speed = dynamicSpeedInfo["BaseSpeed"] as? String{
//                        completionHandler(status: "OK", success: true, speed: speed)
//                        
//                }
//              let status = dictionary["status"] as! String
//                var linkValues = (dictionary["Reponse"]?["Link"] as? [String:AnyObject])!
//                var speedValues = linkValues["DynamicSpeedInfo"] as? [String:AnyObject]
//                println((linkValues["DynamicSpeedInfo"]?["BaseSpeed"] as? String)!)
//                println(String(stringInterpolationSegment: dictionary["Response"]?["Link"]?["DynamicSpeedInfo"]["BaseSpeed"]));
//                completionHandler(status: "", success: true, speed: (linkValues["DynamicSpeedInfo"]?["BaseSpeed"] as? String)!);
//                completionHandler(status: status, success: true, speed: String(stringInterpolationSegment: dictionary["Response"]["Link"]["DynamicSpeedInfo"]["BaseSpeed"]))
                
            }
//        })
        
    }
    
//    func getValue(key: String, value: AnyObject)->AnyObject{
//        return value[
//    }
    
    
    
}