//
//  AppDelegate.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/3/25.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var scheme: String = ""
    var query: String = ""
    var path: String = ""
    var tokenString = ""
    var user:String = ""

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor();
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = LaunchViewController()
        /*if(ToolsString.isEmpty(UrlDAO.getUrl())){
            var rootNavigationController : UINavigationController = UINavigationController(rootViewController: ViewController())
            self.window!.rootViewController = rootNavigationController
        }
            
        else
        {
            //let logoViewController:LogoViewController  = LogoViewController()
            //self.window!.rootViewController = logoViewController
            self.window!.rootViewController = MainController()
        }*/
        
        //SplunkMint
        //        Mint.sharedInstance().initAndStartSession("0cac3155")
        //        if(AccountDAO.getAccountObject() == nil)
        //        {
        
        //        }else
        //        {
        //        }
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
        
        // Override point for customization after application launch.
        return true
    }
    func application(app: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        //print(url.query!)
        scheme = url.scheme!
        path = url.path!
        query = url.query!
        
        // var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
     //   return WXApi.handleOpenURL(url, delegate: self)
         return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if(query != "")
        {
            
            
            if let keyExist = query.getKeyVals()!["user"]
            {
                //  user = query.getKeyVals()!["user"]!
                /*     my += user
                 print("I am ok:" + UAirship.push().channelID!)
                 my += "&deviceid=" + UAirship.push().channelID!
                 my += "&type=i"
                 my += "&station=jd"*/
                self.window?.rootViewController = PushViewController()
            }
            
        }

    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

