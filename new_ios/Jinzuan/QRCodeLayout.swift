//
//  QRCodeLayout.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/13.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit

class QRCodeLayout:UIView {
    
    /** UINavigationController*/
    var uiNavigationItem:UINavigationItem?
    /** 介面Title字串*/
    var titleString:String = "Scan QRCode"
    /** 內容*/
    var contentView:UIView = UIView()
    /** 寬間距*/
    let widthContent:CGFloat = 20.0
    /** 高間距*/
    let heightContent:CGFloat = 10.0
    /** 送出按鈕高度*/
    let sendButtonHeight:CGFloat = 40
    /** 內容View - X座標*/
    var contentView_X:CGFloat = 0.0
    /** 內容View - Y座標*/
    var contentView_Y:CGFloat = 0.0
    /** 內容View - 寬*/
    var contentView_Width:CGFloat = 0.0
    /** 內容View - 高*/
    var contentView_Height:CGFloat = 0.0
    /** 返回tag*/
    let Button_BackTag:Int = 1
    /** 返回按鈕*/
    var back_btn = UIButton()
    /** 秀出鏡頭的畫面 */
    var QRCodeFrameView:UIView?
    /** QR CODE Message*/
    var lblQRCodeLabel: UILabel!
    /** fontsize */
    var fontSize:CGSize!
    
    var titleView:UIView?
    
    var titleLabel:UILabel?
    
    var contentHeight : CGFloat = 5
    
    var titleColorViewHeight : CGFloat = 10
    
    var screen_mul_x:CGFloat = 1
    var screen_mul_y:CGFloat = 1
    
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
        titleLabel?.text = titleString
        titleLabel?.textColor = UIColor.whiteColor()
        titleLabel?.font = title_Font
        let titleWidth = ToolsSize.getSizeFromString((titleLabel?.text)!, withFont: (titleLabel?.font)!)
        if(titleWidth > frame.width){
            titleLabel?.frame = CGRectMake(0,contentHeight,frame.width,0)
        }else{
            titleLabel?.frame = CGRectMake(frame.width/2 - titleWidth/2,contentHeight ,frame.width,0)
        }
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .ByWordWrapping
        titleLabel?.sizeToFit()
        titleView?.frame = CGRectMake(0,startY,frame.width,(titleLabel?.frame.height)! + contentHeight)
        titleView?.backgroundColor = ToolsHexToUIColor.transToUIColor(Colors.c28456f)
        titleView?.addSubview(titleLabel!)
        
        var pb = UIButton()
        back_btn = pb
        back_btn.setImage(UIImage(named:"back"), forState: .Normal)
        back_btn.setImage(UIImage(named:"back"), forState: .Highlighted)
        back_btn.frame = CGRectMake(10, ((titleView?.frame.height)! - 30)/2, 30, 30)
        titleView?.addSubview(back_btn)
        
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
    
    func loadView() {
        
        contentView.frame = CGRectMake(contentView_X,contentView_Y,contentView_Width,contentView_Height)
        contentView.backgroundColor = UIColor.whiteColor()
        self.addSubview(contentView)
        
        //label
        lblQRCodeLabel = UILabel()
        lblQRCodeLabel.text = "請用螢幕中心對準QRCode 以便自動讀取"
        lblQRCodeLabel.font = UIFont(name: "Heiti TC", size: 15*screen_mul_x)
        lblQRCodeLabel.textColor = UIColor.yellowColor()
//        lblQRCodeLabel.frame = CGRectMake(0,UIScreen.mainScreen().bounds, fontSize.width, fontSize.height)
        lblQRCodeLabel.center = CGPoint(x: contentView_Width/2, y: lblQRCodeLabel.center.y)
        lblQRCodeLabel.sizeToFit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
