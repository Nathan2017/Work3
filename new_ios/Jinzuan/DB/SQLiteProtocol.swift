//
//  SQLiteProtocol.swift
//  WebView
//
//  Created by Brain Liao on 2016/3/7.
//  Copyright © 2016年 brainliao. All rights reserved.
//

import Foundation
protocol SQLiteProtocol {
    /**建立table*/
    func onCreate(sQLiteDB:SQLiteDB)
    /**更新table*/
    func onUpgrade(sQLiteDB:SQLiteDB,oldVersion:Int,newVersion:Int)
    
}
