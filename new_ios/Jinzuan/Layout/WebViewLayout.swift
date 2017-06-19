//
//  WebViewLayout.swift
//  WebView
//
//  Created by Brain Liao on 2016/3/7.
//  Copyright © 2016年 brainliao. All rights reserved.
//

import UIKit

class WebViewLayout : UIView{
    
    var webView: UIWebView = UIWebView()
    
    var titleView:UIView?
    
    var titleLabel:UILabel?
    
    var back_btn:UIButton?
    
    var contentHeight : CGFloat = 5
    
    var titleColorViewHeight : CGFloat = 10
    
    init(frame: CGRect,titleStr:String!,showTitleView:Bool) {
        super.init(frame: frame)
        let topBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        var startY = topBarHeight
        if(topBarHeight > 20)
        {
            startY = 0
        }
        var tempTitleView = UIView()
        titleView = tempTitleView
        if(showTitleView){
            let title_Font = UIFont(name: "Heiti TC", size: 22)
            // Title Label
            let now = NSDate()
            var tempTitleLabel = UILabel()
            titleLabel = tempTitleLabel
            titleLabel?.text = titleStr
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
            back_btn!.setImage(UIImage(named:"back"), forState: .Normal)
            back_btn!.setImage(UIImage(named:"back"), forState: .Highlighted)
            back_btn!.frame = CGRectMake(10, ((titleView?.frame.height)! - 30)/2, 30, 30)
            titleView?.addSubview(back_btn!)
            
            addSubview(titleView!);
            
        }else{
            titleView?.frame = CGRectMake(0,startY,frame.width,0)
            titleView?.backgroundColor = UIColor.clearColor()
            var pb = UIButton()
            back_btn = pb
            back_btn!.frame = CGRectMake(0, 0, 0, 0)
            titleView?.addSubview(back_btn!)
            addSubview(titleView!);
        }
        var limitHeight:CGFloat = 0
        if(topBarHeight > 20)
        {
            limitHeight = 20
        }
        webView.frame = CGRectMake(0, (titleView?.frame.origin.y)! + (titleView?.frame.height)!, frame.width , frame.height - ((titleView?.frame.origin.y)! + (titleView?.frame.height)!) - limitHeight)
        webView.backgroundColor = UIColor.whiteColor()
        self.addSubview(webView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
