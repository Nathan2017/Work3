//
//  OfficialAnnouncementTableCell.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/13.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit
class OfficialAnnouncementTableCell: UITableViewCell {
    
    var titleView:UIView = UIView()
    
    var title:UILabel = UILabel()
    
    var timeLabel:UILabel = UILabel ()
    
    var contentShowView:UIView = UIView()
    
    var newImageView:UIImageView = UIImageView()
    
    var arrowImageView:UIImageView = UIImageView()
    
    var contentTextView:UITextView = UITextView()
    /** 內容Font*/
    let contentFont = UIFont.systemFontOfSize(16)
    /** 寬間距*/
    var widthContent:CGFloat = 20.0
    /** 高間距*/
    let heightContent:CGFloat = 10.0
    /** 箭頭寬高*/
    let arrow_widthAndHeight:CGFloat = 10.0
    
    let newImageWidthAndHeight:CGFloat = 20.0
    /** 刪除事件監聽器*/
    var clickListenerProtocol:ClickListenerProtocol?
    /** 系統消息物件*/
    var officialAnnouncementObject:OfficialAnnouncementObject?
    /** 載入圖片錯誤顯示圖片路徑*/
    let defaultNoPhoto:String = "no_photo"
    /** 向下的箭頭 - 未展開時*/
    let arrow_botton = "arrow_bottom"
    /** 向上的箭頭 - 展開時*/
    let arrow_top = "arrow_top"
    /** 未讀*/
    let new_ImageName = "new"
    
    let photoView:UIImageView = UIImageView()
    
    var tableDataSourceClickListenerProtocol:ClickListenerProtocol!
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!,clickListenerProtocol:ClickListenerProtocol!
        ,tableDataSourceClickListenerProtocol:ClickListenerProtocol!){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clickListenerProtocol = clickListenerProtocol
        self.tableDataSourceClickListenerProtocol = tableDataSourceClickListenerProtocol
    }
    
    func updateView(width: CGFloat,officialAnnouncementObject:OfficialAnnouncementObject!){
        self.officialAnnouncementObject = officialAnnouncementObject
        title.removeFromSuperview()
        timeLabel.removeFromSuperview()
        arrowImageView.removeFromSuperview()
        newImageView.removeFromSuperview()
        titleView.removeFromSuperview()
        photoView.removeFromSuperview()
        contentTextView.removeFromSuperview()
        contentShowView.removeFromSuperview()
        
        if(officialAnnouncementObject != nil && !ToolsString.isEmpty(officialAnnouncementObject.Title))
        {
            title.text = officialAnnouncementObject.Title
        }
        title.textColor = ToolsHexToUIColor.transToUIColor(Colors.c373737)
        title.font = contentFont
        title.numberOfLines = 0
        title.lineBreakMode = .ByWordWrapping
        title.frame = CGRectMake(widthContent,heightContent, width-(widthContent)-(widthContent)-arrow_widthAndHeight-widthContent - newImageWidthAndHeight,0)
        title.sizeToFit()
        titleView.addSubview(title)
        //時間Label
        let timeFont = UIFont.systemFontOfSize(12)
        timeLabel.textColor = ToolsHexToUIColor.transToUIColor(Colors.cC8C8C8)
        if(officialAnnouncementObject != nil && !ToolsString.isEmpty(officialAnnouncementObject.CreateDate))
        {
            timeLabel.text = officialAnnouncementObject.CreateDate
        }
        timeLabel.font = timeFont
        let timeWidth:CGFloat = ToolsSize.getSizeFromString(timeLabel.text!, withFont: timeFont)
        timeLabel.frame = CGRectMake(widthContent,title.frame.origin.y + title.frame.height, timeWidth,timeFont.lineHeight)
        titleView.addSubview(timeLabel)
        
        arrowImageView.frame = CGRectMake(width - widthContent - arrow_widthAndHeight
            ,(title.frame.height + timeLabel.frame.height)/2 - arrow_widthAndHeight/2 + heightContent,arrow_widthAndHeight,arrow_widthAndHeight)
        newImageView.frame = CGRectMake(width - widthContent - arrow_widthAndHeight - newImageWidthAndHeight
            ,(title.frame.height + timeLabel.frame.height)/2 - newImageWidthAndHeight/2 + heightContent,newImageWidthAndHeight,newImageWidthAndHeight)
        if(officialAnnouncementObject.IsReaded == nil ||  "0" == officialAnnouncementObject.IsReaded)
        {
            newImageView.image = UIImage(named: new_ImageName)
        }else
        {
            newImageView.image = nil
            
        }
        titleView.addSubview(newImageView)
        titleView.frame = CGRectMake(0,0,width,timeLabel.frame.origin.y + timeLabel.frame.height)
        let titleViewtapRecognizer = UITapGestureRecognizer(target: self, action: #selector(OfficialAnnouncementTableCell.viewTapped(_:)))
        titleView.addGestureRecognizer(titleViewtapRecognizer)
        if(officialAnnouncementObject.IsShow)
        {
//            arrowImageView.image = UIImage(named: arrow_top)
//            titleView.addSubview(arrowImageView)
            self.contentView.addSubview(titleView)
        }else
        {
            arrowImageView.image = UIImage(named: arrow_botton)
            titleView.addSubview(arrowImageView)
            self.contentView.addSubview(titleView)
            return
        }
        contentShowView.backgroundColor = ToolsHexToUIColor.transToUIColor(Colors.cF5F5F5)
        
        photoView.frame = CGRectMake(widthContent,heightContent,0,0)
        contentShowView.addSubview(photoView)
        if(officialAnnouncementObject != nil && !ToolsString.isEmpty(officialAnnouncementObject.Content))
        {
            contentTextView.text = officialAnnouncementObject.Content
        }
        contentTextView.frame = CGRectMake(widthContent,photoView.frame.origin.y + photoView.frame.height,UIScreen.mainScreen().bounds.width-(widthContent)-(widthContent),0)
        contentTextView.editable = false
        contentTextView.backgroundColor = ToolsHexToUIColor.transToUIColor(Colors.cF5F5F5)
        contentTextView.userInteractionEnabled = true;
        contentTextView.scrollEnabled = false
        contentTextView.textColor = ToolsHexToUIColor.transToUIColor(Colors.c909090)
        contentTextView.dataDetectorTypes = UIDataDetectorTypes.All
        contentTextView.sizeToFit()
        contentShowView.addSubview(contentTextView)
        contentShowView.frame = CGRectMake(0,titleView.frame.origin.y + titleView.frame.height,
                                           width,contentTextView.frame.origin.y + contentTextView.frame.height + heightContent)
        self.contentView.addSubview(contentShowView)
        
    }
    
    /** 圖片點擊事件*/
    func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        if(tableDataSourceClickListenerProtocol != nil)
        {
            let clickCondition:ClickListenerCondition = ClickListenerCondition()
            clickCondition.object = officialAnnouncementObject
            tableDataSourceClickListenerProtocol!.DoClicks(clickCondition)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
