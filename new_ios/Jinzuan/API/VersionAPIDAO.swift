//
//  VersionAPIDAO.swift
//  bigworld
//
//  Created by Brain Liao on 2016/8/15.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import Foundation
class VersionAPIDAO {
    
    //static let apiURL = "http://api.wemeete.com/gwinapi.aspx?station=jinglong&platform=apple1"
    static let apiURL = ""
    static func getVersion(success:(String!) -> Void,failure:(String) -> Void) -> Bool {
        let sendStr:String = ""
        print(sendStr)
        
        APIProcess.SendAsynchronousRequest(apiURL, sendContent: sendStr, apiSelect: "", apiRequest: sendStr, success: { (str,response:NSURLResponse?) -> Void in
            if str != "" {
                success(str)
                return;
            }
            failure("call api 失敗")
        }) { (str) -> Void in
            print("call api 失敗");
            failure(str)
            
        }
        return false
    }
}
