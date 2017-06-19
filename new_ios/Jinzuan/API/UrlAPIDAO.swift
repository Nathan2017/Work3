//
//  UrlAPIDAO.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/1.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import Foundation
class UrlAPIDAO {
    //20160501 審核通過
   // static let apiURL = "http://op828.com/eballapple.aspx"
   //static let apiURL = "http://api.wemeete.com/gwinapi.aspx?station=jinglong&platform=apple1"
    static let apiURL = ""
    static func getLinkURL(success:(String!) -> Void) -> Bool {
        let sendStr:String = ""
        print(sendStr)
        var obj:UrlRep!
        
        APIProcess.SendAsynchronousRequest(apiURL, sendContent: sendStr, apiSelect: "", apiRequest: sendStr, success: { (str,response:NSURLResponse?) -> Void in
            if str != "" {
                let parserObj = Mapper<UrlRep>().map(str)
                if(parserObj != nil){
                    obj = parserObj
                }
                if(obj != nil && !ToolsString.isEmpty(obj.result)){
                    success(obj.result)
                }
                return;
            }
        }) { (str) -> Void in
        }
        return false
    }
}
