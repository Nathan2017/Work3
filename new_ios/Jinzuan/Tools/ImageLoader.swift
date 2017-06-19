//
//  ImageLoader.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/8/25.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit
import Foundation


class ImageLoader {
    
    let cache = NSCache()
    
    init() {
        cache.totalCostLimit = 50 * 1024 * 1024 //100 MB
        cache.countLimit = 15
        cache.name = "com.asus.cache"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ImageLoader.clearMemoryCache),
                                                         name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ImageLoader.clearMemoryCache),
                                                         name: UIApplicationDidEnterBackgroundNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @objc internal func clearMemoryCache() {
        cache.removeAllObjects()
    }
    
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            let doImageUrl = urlString.stringByReplacingOccurrencesOfString("\\", withString: "/")
            let data: NSData? = self.cache.objectForKey(doImageUrl) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: doImageUrl)
                })
                return
            }
            
            let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: doImageUrl)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if (error != nil) {
                    completionHandler(image: nil, url: doImageUrl)
                    return
                }
                
                if let data = data {
                    let image = UIImage(data: data)
                    self.cache.setObject(data, forKey: doImageUrl)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: doImageUrl)
                    })
                    return
                }
                
            })
            downloadTask.resume()
        })
        
    }
}
