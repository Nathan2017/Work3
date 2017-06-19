//
//  SQLiteAccount.swift
//  WebView
//
//  Created by Brain Liao on 2016/3/7.
//  Copyright © 2016年 brainliao. All rights reserved.
//

import Foundation
/** SQLite檔案*/
class SQLiteURL:SQLiteDB,SQLiteProtocol{
    /** db name*/
    let DB_NAME = "DBUrl.db"
    /** QUEUE名稱*/
    let QUEUE_LABEL = "SQLiteUrl"
    /** DB版本*/
    let DB_VERSION = 1
    
    required init() {
        super.init(gid: "",db_NAME: DB_NAME, queue_LABEL: QUEUE_LABEL, nowVersion: DB_VERSION)
        checkVersion(self)
    }
    
    required init(gid: String, db_NAME: String, queue_LABEL: String, nowVersion: Int) {
        fatalError("init(gid:db_NAME:queue_LABEL:nowVersion:) has not been implemented")
    }
    
    
    /**建立table*/
    func onCreate(sQLiteDB:SQLiteDB)
    {
        let sql = "CREATE TABLE IF NOT EXISTS " + "TableURL" + "("
            + "url" + " );"	;
        sQLiteDB.execute(sql)
    }
    /**更新table*/
    func onUpgrade(sQLiteDB:SQLiteDB,oldVersion:Int,newVersion:Int)
    {
        print("版本更新")
        sQLiteDB.execute("DROP TABLE IF EXISTS " + "TableURL"); //刪除舊有的資料表
        onCreate(sQLiteDB);
    }
    
}
