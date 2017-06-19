//
//  PushViewController.swift
//  Jinzuan
//
//  Created by Rocky on 12/5/16.
//  Copyright © 2016 Jinzuan. All rights reserved.
//

import UIKit
import AirshipKit
class PushViewController: UIViewController {
   // var my = "http://api.wemeete.com/AppPhonIdRecord.aspx?userid="
    var my = ""
    //var my = "http://192.168.1.61/Nathan/System/AppPhonIdRecord.aspx?userid="
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
      //  registerForPushNotification(UIApplication.sharedApplication())
        UAirship.takeOff()
        UAirship.push().userPushNotificationsEnabled = true
       
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let results = appdelegate.query.getKeyVals()!
        //print(results)
        if let v = results["user"]{
            my += results["user"]!
        }
        //let jk = UAirship.push().channelID
        
      /*  while UAirship.push().channelID == nil {
            print(123)
        }*/
        my += "&deviceid=" + UAirship.push().channelID!
        my += "&type=i"
        my += "&station=jinglong"
        print("Jesus:"+my)
        var url:NSURL = NSURL(string: my)!
        let request = NSMutableURLRequest(URL:url)
        // Do any additional setup after loading the view.
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            if(error != nil)
            {
                print(error)
                return
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.setupAlert()
            }
            
            
            
        }
        task.resume()

    }
    func setupAlert(){
        var alert = UIAlertController(title: "", message: "已綁定APP", preferredStyle: .Alert)
        var al = UIAlertAction(title: "OK", style: .Default, handler: {(alert) in
            exit(0)
        })
        alert.addAction(al)
        self.presentViewController(alert, animated: false, completion: nil)

    }

    func registerForPushNotification(application: UIApplication)
    {
        let notificationSetting = UIUserNotificationSettings(forTypes: [.Badge,.Alert,.Sound], categories: nil)
        application.registerUserNotificationSettings(notificationSetting)
    }

    

}
