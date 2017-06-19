//
//  AccountDAO.swift
//  WebView
//
//  Created by Brain Liao on 2016/3/7.
//  Copyright © 2016年 brainliao. All rights reserved.
//

class UrlDAO {
    
    /** INSERT 連結資訊*/
    internal static func insertUrl(url:String!) -> Bool
    {
        if(url == nil)
        {
            return false
        }
        deleteUrl()
        let sql = "INSERT INTO " + "TableURL"
            + "("+"url" + ") values('\(ToolsString.transToString(url))')"
        //        print("sql: \(sql)")
        let resultInt = DatabaseManagerForURL.getInstance().execute(sql)
        return !(resultInt == 0)
    }
    
    /** 刪除連結資料*/
    internal static func deleteUrl() -> Bool
    {
        let sql = "DELETE FROM " + "TableURL"
        //        print("sql: \(sql)")
        let resultInt = DatabaseManagerForURL.getInstance().execute(sql)
        return !(resultInt == 0)
    }
    
    
    /** 取得連結資料*/
    static func getUrl() -> String?
    {
        var url:String? = nil
        let data = DatabaseManagerForURL.getInstance()
            .query("SELECT * FROM " + "TableURL" + "")
        if(data.count > 0)
        {
           
            let row = data[0]
            if let urlTemp = row["url"] {
                url  = urlTemp as! String
            }
            return url;
        }
        return url
    }
}
