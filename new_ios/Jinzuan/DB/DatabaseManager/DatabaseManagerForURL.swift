//
//  DatabaseManagerForAccount.swift
//  WebView
//
//  Created by Brain Liao on 2016/3/7.
//  Copyright © 2016年 brainliao. All rights reserved.
//

import Foundation
class DatabaseManagerForURL {
    /** 帳號登入DB執行*/
    private static var instance:SQLiteURL!
    /** 檢測記憶體是否已有DB初始化過*/
    private static var token:dispatch_once_t = 0
    
    internal static func getInstance()->SQLiteURL
    {
        dispatch_once(&token) {
            instance = SQLiteURL()
        }
        return instance
    }
    
}
