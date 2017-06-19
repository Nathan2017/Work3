//
//  SQLiteDB.swift
//  ManDan
//
//  Created by Brain Liao on 2015/11/28.
//  Copyright © 2015年 com.CHomeStudy. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

let SQLITE_DATE = SQLITE_NULL + 1

private let SQLITE_STATIC = unsafeBitCast(0, sqlite3_destructor_type.self)
private let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)

// MARK:- SQLiteDB Class - Does all the work
class SQLiteDB {
    //let DB_NAME = "data.db"
    //let QUEUE_LABEL = "SQLiteDB"
    private var db:COpaquePointer = nil
    private var queue:dispatch_queue_t
    private var fmt = NSDateFormatter()
    private var GROUP = ""
    
    private var db_NAME:String!
    
    private var queue_LABEL:String!
    
    private var nowVersion:Int!
    
    required init(gid:String,db_NAME:String,queue_LABEL:String,nowVersion:Int) {
        assert(true, "Singleton already initialized!")
        self.db_NAME = db_NAME
        self.queue_LABEL = queue_LABEL
        self.nowVersion = nowVersion
        GROUP = gid
        // Set queue
        queue = dispatch_queue_create(queue_LABEL, nil)
        fmt.timeZone = NSTimeZone(forSecondsFromGMT:0)
        // Set up for file operations
        let fm = NSFileManager.defaultManager()
        let dbName:String = String.fromCString(db_NAME)!
        var docDir = ""
        // Is this for an app group?
        if GROUP.isEmpty {
            // Get path to DB in Documents directory
            docDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        } else {
            // Get path to shared group folder
            if let url = fm.containerURLForSecurityApplicationGroupIdentifier(GROUP) {
                docDir = url.path!
            } else {
                assert(false, "Error getting container URL for group: \(GROUP)")
            }
        }
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent(dbName)
        let dbPath: String = fileURL!.path!
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(dbPath) {
            let documentsURL = NSBundle.mainBundle().resourceURL
            let fromPath = documentsURL!.URLByAppendingPathComponent(dbName as String)
            var error : NSError?
            do {
                try fm.createFileAtPath(dbPath, contents: nil, attributes: nil)
            } catch let error1 as NSError {
                error = error1
            }
            
            if (error != nil) {
                print("Error Occured: " + (error?.localizedDescription)!)
            } else {
                print("Successfully Copy: Your database copy successfully!")
            }
        }

        
        
        let fileURL2 = documentsURL.URLByAppendingPathComponent(dbName)
        let databasePath = fileURL2!.path
        
        if !fm.fileExistsAtPath(databasePath!) {
            print("Error: " + dbName + " file not found")
        }
        else {
//            print("Success: " + dbName + " is exists")
        }

//        let path = (docDir as NSString).stringByAppendingPathComponent(dbName)
//        print("Database path: \(path)")
        // Check if copy of DB is there in Documents directory
//        if !(fm.fileExistsAtPath(path)) {
//            // The database does not exist, so copy to Documents directory
//            do {
//               // try fm.createFileAtPath(path, contents: nil, attributes: nil)
//                
//               // try fm.copyItemAtPath(from, toPath:path)
//            } catch let error as NSError {
//                print("SQLiteDB - failed to copy writable version of DB!")
//                print("Error - \(error.localizedDescription)")
//                return
//            }
//        }
        // Open the DB
        let cpath = databasePath!.cStringUsingEncoding(NSUTF8StringEncoding)
        let error = sqlite3_open(cpath!, &db)
        if error != SQLITE_OK {
            // Open failed, close DB and fail
            print("SQLiteDB - failed to open DB!")
            sqlite3_close(db)
        }
        fmt.dateFormat = "YYYY-MM-dd HH:mm:ss"
    }
    
    deinit {
        closeDatabase()
    }
    
    func checkVersion(sQLiteProtocol:SQLiteProtocol)
    {
        let versionData = self.query("select * from Version")
        if versionData.count > 0 {
            let versionRow = versionData[versionData.count - 1]
            let version = versionRow["Version"] as? Int
            if(nowVersion > version)
            {
                sQLiteProtocol.onUpgrade(self, oldVersion: version!, newVersion: nowVersion)
                let updateSQL = "update Version SET Version = '" + String(nowVersion) + "'"
                self.execute(updateSQL)
            }

        }else{
            self.execute("create table if not exists Version(Version integer)")
            let createSQL = "insert into Version(version) values('\(nowVersion)')"
            self.execute(createSQL)
            sQLiteProtocol.onCreate(self)
        }
    }
    
    private func closeDatabase() {
        if db != nil {
            // Get launch count value
            let ud = NSUserDefaults.standardUserDefaults()
            var launchCount = ud.integerForKey("LaunchCount")
            launchCount--
            print("SQLiteDB - Launch count \(launchCount)")
            var clean = false
            if launchCount < 0 {
                clean = true
                launchCount = 500
            }
            ud.setInteger(launchCount, forKey: "LaunchCount")
            ud.synchronize()
            // Do we clean DB?
            if !clean {
                sqlite3_close(db)
                return
            }
            // Clean DB
            print("SQLiteDB - Optimize DB")
            let sql = "VACUUM; ANALYZE"
            if execute(sql) != SQLITE_OK {
                print("SQLiteDB - Error cleaning DB")
            }
            sqlite3_close(db)
        }
    }
    
    // Execute SQL with parameters and return result code
    func execute(sql:String, parameters:[AnyObject]?=nil)->CInt {
        var result:CInt = 0
        dispatch_sync(queue) {
            let stmt = self.prepare(sql, params:parameters)
            if stmt != nil {
                result = self.execute(stmt, sql:sql)
            }
        }
        return result
    }
    
    // Run SQL query with parameters
    func query(sql:String, parameters:[AnyObject]?=nil)->[[String:AnyObject]] {
        var rows = [[String:AnyObject]]()
        // print("sql: \(sql)")
        dispatch_sync(queue) {
            let stmt = self.prepare(sql, params:parameters)
            if stmt != nil {
                rows = self.query(stmt, sql:sql)
            }
        }
        return rows
    }
    
    // Show alert with either supplied message or last error
    func alert(msg:String) {
        dispatch_async(dispatch_get_main_queue()) {
            #if os(iOS)
                let alert = UIAlertView(title: "SQLiteDB", message:msg, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            #else
                let alert = NSAlert()
                alert.addButtonWithTitle("OK")
                alert.messageText = "SQLiteDB"
                alert.informativeText = msg
                alert.alertStyle = NSAlertStyle.WarningAlertStyle
                alert.runModal()
            #endif
        }
    }
    
    // Private method which prepares the SQL
    private func prepare(sql:String, params:[AnyObject]?)->COpaquePointer {
        var stmt:COpaquePointer = nil
        let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
        // Prepare
        let result = sqlite3_prepare_v2(self.db, cSql!, -1, &stmt, nil)
        if result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if let error = String.fromCString(sqlite3_errmsg(self.db)) {
                let msg = "SQLiteDB - failed to prepare SQL: \(sql), Error: \(error)"
                print(msg)
            }
            return nil
        }
        // Bind parameters, if any
        if params != nil {
            // Validate parameters
            let cntParams = sqlite3_bind_parameter_count(stmt)
            let cnt = CInt(params!.count)
            if cntParams != cnt {
                let msg = "SQLiteDB - failed to bind parameters, counts did not match. SQL: \(sql), Parameters: \(params)"
                print(msg)
                return nil
            }
            var flag:CInt = 0
            // Text & BLOB values passed to a C-API do not work correctly if they are not marked as transient.
            for ndx in 1...cnt {
                //				println("Binding: \(params![ndx-1]) at Index: \(ndx)")
                // Check for data types
                if let txt = params![ndx-1] as? String {
                    flag = sqlite3_bind_text(stmt, CInt(ndx), txt, -1, SQLITE_TRANSIENT)
                } else if let data = params![ndx-1] as? NSData {
                    flag = sqlite3_bind_blob(stmt, CInt(ndx), data.bytes, CInt(data.length), SQLITE_TRANSIENT)
                } else if let date = params![ndx-1] as? NSDate {
                    let txt = fmt.stringFromDate(date)
                    flag = sqlite3_bind_text(stmt, CInt(ndx), txt, -1, SQLITE_TRANSIENT)
                } else if let val = params![ndx-1] as? Double {
                    flag = sqlite3_bind_double(stmt, CInt(ndx), CDouble(val))
                } else if let val = params![ndx-1] as? Int {
                    flag = sqlite3_bind_int(stmt, CInt(ndx), CInt(val))
                } else {
                    flag = sqlite3_bind_null(stmt, CInt(ndx))
                }
                // Check for errors
                if flag != SQLITE_OK {
                    sqlite3_finalize(stmt)
                    if let error = String.fromCString(sqlite3_errmsg(self.db)) {
                        let msg = "SQLiteDB - failed to bind for SQL: \(sql), Parameters: \(params), Index: \(ndx) Error: \(error)"
                        print(msg)
                    }
                    return nil
                }
            }
        }
        return stmt
    }
    
    // Private method which handles the actual execution of an SQL statement
    private func execute(stmt:COpaquePointer, sql:String)->CInt {
        // Step
        var result = sqlite3_step(stmt)
        if result != SQLITE_OK && result != SQLITE_DONE {
            sqlite3_finalize(stmt)
            if let err = String.fromCString(sqlite3_errmsg(self.db)) {
                let msg = "SQLiteDB - failed to execute SQL: \(sql), Error: \(err)"
                print(msg)
            }
            return 0
        }
        // Is this an insert
        let upp = sql.uppercaseString
        if upp.hasPrefix("INSERT ") {
            // Known limitations: http://www.sqlite.org/c3ref/last_insert_rowid.html
            let rid = sqlite3_last_insert_rowid(self.db)
            result = CInt(rid)
        } else if upp.hasPrefix("DELETE") || upp.hasPrefix("UPDATE") {
            var cnt = sqlite3_changes(self.db)
            if cnt == 0 {
                cnt++
            }
            result = CInt(cnt)
        } else {
            result = 1
        }
        // Finalize
        sqlite3_finalize(stmt)
        return result
    }
    
    // Private method which handles the actual execution of an SQL query
    private func query(stmt:COpaquePointer, sql:String)->[[String:AnyObject]] {
        var rows = [[String:AnyObject]]()
        var fetchColumnInfo = true
        var columnCount:CInt = 0
        var columnNames = [String]()
        var columnTypes = [CInt]()
        var result = sqlite3_step(stmt)
        while result == SQLITE_ROW {
            // Should we get column info?
            if fetchColumnInfo {
                columnCount = sqlite3_column_count(stmt)
                for index in 0..<columnCount {
                    // Get column name
                    let name = sqlite3_column_name(stmt, index)
                    columnNames.append(String.fromCString(name)!)
                    // Get column type
                    columnTypes.append(self.getColumnType(index, stmt:stmt))
                }
                fetchColumnInfo = false
            }
            // Get row data for each column
            var row = [String:AnyObject]()
            for index in 0..<columnCount {
                let key = columnNames[Int(index)]
                let type = columnTypes[Int(index)]
                if let val = getColumnValue(index, type:type, stmt:stmt) {
                    //						println("Column type:\(type) with value:\(val)")
                    row[key] = val
                }
            }
            rows.append(row)
            // Next row
            result = sqlite3_step(stmt)
        }
        sqlite3_finalize(stmt)
        return rows
    }
    
    // Get column type
    private func getColumnType(index:CInt, stmt:COpaquePointer)->CInt {
        var type:CInt = 0
        // Column types - http://www.sqlite.org/datatype3.html (section 2.2 table column 1)
        let blobTypes = ["BINARY", "BLOB", "VARBINARY"]
        let charTypes = ["CHAR", "CHARACTER", "CLOB", "NATIONAL VARYING CHARACTER", "NATIVE CHARACTER", "NCHAR", "NVARCHAR", "TEXT", "VARCHAR", "VARIANT", "VARYING CHARACTER"]
        let dateTypes = ["DATE", "DATETIME", "TIME", "TIMESTAMP"]
        let intTypes  = ["BIGINT", "BIT", "BOOL", "BOOLEAN", "INT", "INT2", "INT8", "INTEGER", "MEDIUMINT", "SMALLINT", "TINYINT"]
        let nullTypes = ["NULL"]
        let realTypes = ["DECIMAL", "DOUBLE", "DOUBLE PRECISION", "FLOAT", "NUMERIC", "REAL"]
        // Determine type of column - http://www.sqlite.org/c3ref/c_blob.html
        let buf = sqlite3_column_decltype(stmt, index)
        //		println("SQLiteDB - Got column type: \(buf)")
        if buf != nil {
            var tmp = String.fromCString(buf)!.uppercaseString
            // Remove brackets
            let pos = tmp.positionOf("(")
            if pos > 0 {
                tmp = tmp.subStringTo(pos)
            }
            // Remove unsigned?
            // Remove spaces
            // Is the data type in any of the pre-set values?
            //			println("SQLiteDB - Cleaned up column type: \(tmp)")
            if intTypes.contains(tmp) {
                return SQLITE_INTEGER
            }
            if realTypes.contains(tmp) {
                return SQLITE_FLOAT
            }
            if charTypes.contains(tmp) {
                return SQLITE_TEXT
            }
            if blobTypes.contains(tmp) {
                return SQLITE_BLOB
            }
            if nullTypes.contains(tmp) {
                return SQLITE_NULL
            }
            if dateTypes.contains(tmp) {
                return SQLITE_DATE
            }
            return SQLITE_TEXT
        } else {
            // For expressions and sub-queries
            type = sqlite3_column_type(stmt, index)
        }
        return type
    }
    
    // Get column value
    private func getColumnValue(index:CInt, type:CInt, stmt:COpaquePointer)->AnyObject? {
        // Integer
        if type == SQLITE_INTEGER {
            let val = sqlite3_column_int(stmt, index)
            return Int(val)
        }
        // Float
        if type == SQLITE_FLOAT {
            let val = sqlite3_column_double(stmt, index)
            return Double(val)
        }
        // Text - handled by default handler at end
        // Blob
        if type == SQLITE_BLOB {
            let data = sqlite3_column_blob(stmt, index)
            let size = sqlite3_column_bytes(stmt, index)
            let val = NSData(bytes:data, length: Int(size))
            return val
        }
        // Null
        if type == SQLITE_NULL {
            return nil
        }
        // Date
        if type == SQLITE_DATE {
            // Is this a text date
            let txt = UnsafePointer<Int8>(sqlite3_column_text(stmt, index))
            if txt != nil {
                if let buf = NSString(CString:txt, encoding:NSUTF8StringEncoding) {
                    let set = NSCharacterSet(charactersInString: "-:")
                    let range = buf.rangeOfCharacterFromSet(set)
                    if range.location != NSNotFound {
                        // Convert to time
                        var time:tm = tm(tm_sec: 0, tm_min: 0, tm_hour: 0, tm_mday: 0, tm_mon: 0, tm_year: 0, tm_wday: 0, tm_yday: 0, tm_isdst: 0, tm_gmtoff: 0, tm_zone:nil)
                        strptime(txt, "%Y-%m-%d %H:%M:%S", &time)
                        time.tm_isdst = -1
                        let diff = NSTimeZone.localTimeZone().secondsFromGMT
                        let t = mktime(&time) + diff
                        let ti = NSTimeInterval(t)
                        let val = NSDate(timeIntervalSince1970:ti)
                        return val
                    }
                }
            }
            // If not a text date, then it's a time interval
            let val = sqlite3_column_double(stmt, index)
            let dt = NSDate(timeIntervalSince1970: val)
            return dt
        }
        // If nothing works, return a string representation
        let buf = UnsafePointer<Int8>(sqlite3_column_text(stmt, index))
        let val = String.fromCString(buf)
        return val
    }
}
