//
//  ImageAPIDAO.swift
//  Nathan
//
//  Created by Rocky on 2016/9/13.
//  Copyright © 2016年 Nathan. All rights reserved.
//

import Foundation

class ImgAPIDAO {
    
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
