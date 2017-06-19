//
//  OfficialAnnouncementLayout.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/13.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit
/** 系統消息維護介面*/
class OfficialAnnouncementLayout: UIView {
    /** UINavigationController*/
    var uiNavigationItem:UINavigationItem?
    /** 系統消息介面Title字串*/
    var titleString:String = "系統消息"
    /** 內容*/
    var contentView:UIView = UIView()
    /** 寬間距*/
    let widthContent:CGFloat = 20.0
    /** 高間距*/
    let heightContent:CGFloat = 10.0
    /** 內容View - X座標*/
    var contentView_X:CGFloat = 0.0
    /** 內容View - Y座標*/
    var contentView_Y:CGFloat = 0.0
    /** 內容View - 寬*/
    var contentView_Width:CGFloat = 0.0
    /** 內容View - 高*/
    var contentView_Height:CGFloat = 0.0
    /** 返回按鈕*/
    let push_btn = UIButton()
    /** 返回按鈕Tag*/
    let Button_Push:Int = 0
    /** 機構消息管理 TableView*/
    var tableView:UITableView = UITableView()
    
    var titleView:UIView?
    
    var titleLabel:UILabel?
    
    var back_btn:UIButton?
    
    var contentHeight : CGFloat = 5
    
    var titleColorViewHeight : CGFloat = 10
    
    /**
     初始化
     @param uiNavigationItem UINavigationItem
     @param 座標及寬高
     */
    init(frame:CGRect,navigationBarFrame:CGRect?,uiNavigationItem:UINavigationItem) {
        
       
        super.init(frame: frame)
        let topBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        var startY = topBarHeight
        if(topBarHeight > 20)
        {
            startY = 0
        }
        var tempTitleView = UIView()
        titleView = tempTitleView
            let title_Font = UIFont(name: "Heiti TC", size: 22)
            // Title Label
            let now = NSDate()
            var tempTitleLabel = UILabel()
            titleLabel = tempTitleLabel
            titleLabel?.text = "系統訊息"
            titleLabel?.textColor = UIColor.whiteColor()
            titleLabel?.font = title_Font
            let titleWidth = ToolsSize.getSizeFromString((titleLabel?.text)!, withFont: (titleLabel?.font)!)
            if(titleWidth > frame.width){
                titleLabel?.frame = CGRectMake(0,contentHeight+20,frame.width,0)
            }else{
                titleLabel?.frame = CGRectMake(frame.width/2 - titleWidth/2,contentHeight+20 ,frame.width,0)
            }
            titleLabel?.numberOfLines = 0
            titleLabel?.lineBreakMode = .ByWordWrapping
            titleLabel?.sizeToFit()
            titleView?.frame = CGRectMake(0,0,frame.width,(titleLabel?.frame.height)! + contentHeight+20)
            titleView?.backgroundColor = ToolsHexToUIColor.transToUIColor(Colors.abcdefg)
            titleView?.addSubview(titleLabel!)
            
          /*  var pb = UIButton()
            back_btn = pb
            back_btn!.setImage(UIImage(named:"back"), forState: .Normal)
            back_btn!.setImage(UIImage(named:"back"), forState: .Highlighted)
            back_btn!.frame = CGRectMake(10, ((titleView?.frame.height)! - 30)/2, 30, 30)*/
          //  titleView?.addSubview(back_btn!)
            
            addSubview(titleView!);
            
       
        var limitHeight:CGFloat = 0
        if(topBarHeight > 20)
        {
            limitHeight = 20
        }
        contentView_X = 0.0
        contentView_Y = (titleView?.frame.origin.y)! + (titleView?.frame.height)!
        contentView_Width = frame.width
        contentView_Height = frame.height - ((titleView?.frame.origin.y)! + (titleView?.frame.height)!) - limitHeight
        
    }
    
    /** 載入畫面*/
    func loadView()
    {
        contentView.frame = CGRectMake(contentView_X,contentView_Y,contentView_Width,contentView_Height)
        addSubview(contentView)
        //重要經過測試若ContentView 僅TableView一個時,會自定偏移,故調整新增一個假的
        //固定欄位
        let fakeView:UIView = UIView()
        fakeView.frame = CGRectMake(0, 0, 0, 0)
        contentView.addSubview(fakeView)
        //固定欄位
        
        tableView = UITableView()
        tableView.frame = CGRectMake(0,0,contentView_Width,contentView_Height)
        //tableView.backgroundColor = UIColor.blueColor()
        contentView.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

