//
//  APIProcess.swift
//  WebView
//
//  Created by Brain Liao on 2016/3/18.
//  Copyright © 2016年 brainliao. All rights reserved.
//
import Foundation
class APIProcess:NSObject {
    
    
    
    //統一處理傳送單元
    static func SendAsynchronousRequest(apiStr:String!,sendContent:String!, apiSelect:String!, apiRequest:String!,success:(String,response:NSURLResponse) -> Void, failure:(String) -> Void){
        //宣告一個 NSMutableURLRequest 並給予一個記憶體空間
        var request:NSMutableURLRequest!
        //宣告要post的值
        var httpBodyString:NSString!
        
        request = NSMutableURLRequest(URL: NSURL(string: apiStr + apiSelect)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15.0)
        
        print(apiStr + apiSelect)
        //NSMutableURLRequest(URL: NSURL(string: apiStr + apiSelect)!)
        request.HTTPMethod = "GET"
        request.timeoutInterval = 15
        request.HTTPShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        httpBodyString = NSString(format: "%@", sendContent)
        request.HTTPBody = httpBodyString.dataUsingEncoding(NSUTF8StringEncoding)
        do {
            try NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response: NSURLResponse?, data: NSData?,  error: NSError?) -> Void in
                
                if(error != nil)
                {
                    failure(error!.description)
                    return
                }
                
                
                let result = (NSString(data: data!, encoding: NSUTF8StringEncoding))
                if(result != nil){
                    let returnStr =  result! as String
                    success(returnStr,response: response!)
                }
            })
        }
        catch {
            print("執行NSURLConnection.sendAsynchronousRequest失敗")
            return
        }
    }

    
}

