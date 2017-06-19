//
//  OfficialAnnouncementTableDataSource.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/13.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//
import UIKit
import Foundation
class OfficialAnnouncementTableDataSource: NSObject,UITableViewDataSource,UITableViewDelegate,ClickListenerProtocol{
    
    /** 資料List*/
    var datas:[OfficialAnnouncementObject]
    /** TableView*/
    let tableView:UITableView
    /** 監聽器*/
    let clickListenerProtocol:ClickListenerProtocol?
    /** 內容Font*/
    let contentFont = UIFont.systemFontOfSize(16)
    /** 寬間距*/
    let widthContent:CGFloat = 20.0
    /** 高間距*/
    let heightContent:CGFloat = 10.0
    /** 箭頭寬高*/
    let arrow_widthAndHeight:CGFloat = 10.0
    /** 初始化*/
    init(datas:[OfficialAnnouncementObject],tableView:UITableView,clickListenerProtocol:ClickListenerProtocol!) {
        self.datas = datas
        self.tableView = tableView
        self.clickListenerProtocol = clickListenerProtocol
        super.init()
    }
    
    /**觸發點擊事件 - 無傳遞參數*/
    func DoClicks()
    {
    }
    /**觸發點擊事件 - 有傳遞參數*/
    func DoClicks(clickListenerCondition:ClickListenerCondition)
    {
      
            let obj = clickListenerCondition.object as! OfficialAnnouncementObject
            
            if( clickListenerProtocol != nil)
            {
                let clickListenerCondition:ClickListenerCondition = ClickListenerCondition()
                clickListenerCondition.object = obj
                clickListenerProtocol?.DoClicks(clickListenerCondition)
            }
    }
    
    
    
    func updateData(datas:[OfficialAnnouncementObject])
    {
        self.datas = datas
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var officialAnnouncementObject:OfficialAnnouncementObject!
        
        if(datas.count > 0)
        {
            officialAnnouncementObject = datas[indexPath.row]
        }
        //若無搜尋到院所消息物件,return空TableCell
        if(officialAnnouncementObject == nil)
        {
            return UITableViewCell()
        }
        
        let cellName:String = "cell_SYS_OfficialAnnouncement"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellName)
        if cell == nil  {
            cell = OfficialAnnouncementTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellName,clickListenerProtocol: clickListenerProtocol,tableDataSourceClickListenerProtocol: self)
            cell!.selectionStyle = UITableViewCellSelectionStyle.None;
        }
        
        let cellObject = cell as! OfficialAnnouncementTableCell
        cellObject.updateView(tableView.frame.width,officialAnnouncementObject: officialAnnouncementObject)
        
        return cellObject
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count : " + String(datas.count))
        return datas.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        var officialAnnouncementObject:OfficialAnnouncementObject!
        //
        //        if(datas.count > 0)
        //        {
        //            officialAnnouncementObject = datas[indexPath.row]
        //        }
        //
        //        if(officialAnnouncementObject != nil && clickListenerProtocol != nil)
        //        {
        //            let clickListenerCondition:ClickListenerCondition = ClickListenerCondition()
        //            clickListenerCondition.clickListenerEnum = ClickListenerEnum.VIEW
        //            clickListenerCondition.object = officialAnnouncementObject
        //            clickListenerProtocol?.DoClicks(clickListenerCondition)
        //        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var officialAnnouncementObject:OfficialAnnouncementObject!
        
        if(datas.count > 0)
        {
            officialAnnouncementObject = datas[indexPath.row]
        }
        if(officialAnnouncementObject == nil)
        {
            return 300.0
        }
        var realHeigh:CGFloat = 0.0
        let title:UILabel = UILabel()
        if(officialAnnouncementObject != nil && !ToolsString.isEmpty(officialAnnouncementObject.Title))
        {
            title.text = officialAnnouncementObject.Title
        }
        title.font = UIFont.systemFontOfSize(16)
        title.numberOfLines = 0
        title.lineBreakMode = .ByWordWrapping
        title.frame = CGRectMake(0,heightContent, tableView.frame.size.width-(widthContent)-(widthContent)-arrow_widthAndHeight-widthContent,0)
        title.sizeToFit()
        realHeigh += (title.frame.origin.y + title.frame.height)
        
        //時間Label
        let timeFont = UIFont.systemFontOfSize(12)
        realHeigh += timeFont.lineHeight
        if(!officialAnnouncementObject.IsShow)
        {
            return realHeigh
        }
        let contentTextView:UITextView = UITextView()
        if(officialAnnouncementObject != nil && !ToolsString.isEmpty(officialAnnouncementObject.Content))
        {
            contentTextView.text = officialAnnouncementObject.Content
        }
        contentTextView.frame = CGRectMake(0,0,tableView.frame.size.width-(widthContent)-(widthContent),0)
        contentTextView.editable = false
        contentTextView.userInteractionEnabled = true;
        contentTextView.scrollEnabled = false
        contentTextView.dataDetectorTypes = UIDataDetectorTypes.All
        contentTextView.sizeToFit()
        realHeigh += contentTextView.frame.height
        realHeigh += heightContent
        return realHeigh
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var officialAnnouncementObject:OfficialAnnouncementObject!
        if(datas.count > 0)
        {
            officialAnnouncementObject = datas[indexPath.row]
        }
        if(officialAnnouncementObject == nil)
        {
            return 300.0
        }
        var realHeigh:CGFloat = 0.0
        let title:UILabel = UILabel()
        if(officialAnnouncementObject != nil && !ToolsString.isEmpty(officialAnnouncementObject.Title))
        {
            title.text = officialAnnouncementObject.Title
        }
        title.font = UIFont.systemFontOfSize(16)
        title.numberOfLines = 0
        title.lineBreakMode = .ByWordWrapping
        title.frame = CGRectMake(0,heightContent, tableView.frame.size.width-(widthContent)-(widthContent)-arrow_widthAndHeight-widthContent,0)
        title.sizeToFit()
        realHeigh += (title.frame.origin.y + title.frame.height)
        
        //時間Label
        let timeFont = UIFont.systemFontOfSize(12)
        realHeigh += timeFont.lineHeight
        
        if(!officialAnnouncementObject.IsShow)
        {
            return realHeigh
        }
        realHeigh += (heightContent )
        
        
        let contentTextView:UITextView = UITextView()
        if(officialAnnouncementObject != nil && !ToolsString.isEmpty(officialAnnouncementObject.Content))
        {
            contentTextView.text = officialAnnouncementObject.Content
        }
        contentTextView.frame = CGRectMake(0,0,tableView.frame.size.width-(widthContent)-(widthContent),0)
        contentTextView.editable = false
        contentTextView.userInteractionEnabled = true;
        contentTextView.scrollEnabled = false
        contentTextView.dataDetectorTypes = UIDataDetectorTypes.All
        contentTextView.sizeToFit()
        realHeigh += contentTextView.frame.height
        realHeigh += heightContent
        return realHeigh
        
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
}
