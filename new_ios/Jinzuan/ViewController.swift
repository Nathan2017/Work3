//
//  ViewController.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/3/25.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIGestureRecognizerDelegate,UIWebViewDelegate{
    
    var menuLayout:MenuLayout?
    
    var logoLayout:LogoLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        var tempLayout = MenuLayout(frame: self.view.frame)
        menuLayout = tempLayout
        self.view.addSubview(menuLayout!)
        initSettingTap();
        UrlAPIDAO.getLinkURL { (str) in
            UrlDAO.insertUrl(str)
            dispatch_async(dispatch_get_main_queue(),{
                if(!ToolsString.isEmpty(UrlDAO.getUrl()))
                {
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.presentViewController(MainController(),animated: true, completion: nil)
                        //self.addWebViewLayout(str);
                        // self.addLogoLayout(str)
                        // self.openLink(str)
                    });
                }

            });
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func addLogoLayout(str:String){
        logoLayout = LogoLayout(frame: self.view.frame)
        self.view.addSubview(logoLayout);
        initTap();
    }
    
    func initTap (){
        logoLayout.logo.userInteractionEnabled = true
        let vr = UITapGestureRecognizer(target:self, action: "gotoUrl:")
        logoLayout.logo.addGestureRecognizer(vr)
    }
    
    func gotoUrl(sender: UITapGestureRecognizer){
        if(!ToolsString.isEmpty(UrlDAO.getUrl()))
        {
            openLink(UrlDAO.getUrl()!);
            
        }
    }
    
    func openLink(str:String){
        dispatch_async(dispatch_get_main_queue(),{
            if let checkURL = NSURL(string: UrlDAO.getUrl()!) {
                if UIApplication.sharedApplication().openURL(checkURL) {
                    
                }
            }
        });
    }
    
    func addWebViewLayout(str:String)
    {
        var webViewLayout = WebViewLayout(frame: self.view.frame, titleStr: "", showTitleView: false);
        let url: NSURL = NSURL(string: str)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        webViewLayout.webView.scalesPageToFit = true
        webViewLayout.webView.loadRequest(request)
        webViewLayout.webView.delegate = self
        self.view.addSubview(webViewLayout)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        switch navigationType {
        case .LinkClicked:
            // Open links in Safari
            let checkApk = request.URL!.absoluteString!.rangeOfString("apk")
            if((checkApk) != nil)
            {
                showAlert("此為Apk檔,Apple無法下載")
            }
            //            else
            //            {
            //                UIApplication.sharedApplication().openURL(request.URL!)
            //            }
            return true
        default:
            // Handle other navigation types...
            return true
        }
    }
    
    func showAlert(message : String)
    {
        dispatch_async(dispatch_get_main_queue(),{
            var alert : UIAlertView = UIAlertView(title: "提示", message: message,       delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        })
    }

    
    func initSettingTap()
    {
        
        var i:Int = 0
        for v in (self.menuLayout?.iconViewArray1)!
        {
            v.userInteractionEnabled = true
            v.tag = i
            i++
            let vr = UITapGestureRecognizer(target:self, action: "gotoNextView1:")
            v.addGestureRecognizer(vr)
            
        }
        
//        var k:Int = 0
//        for v in (self.menuLayout?.iconViewArray2)!
//        {
//            v.userInteractionEnabled = true
//            v.tag = k
//            k++
//            let vr = UITapGestureRecognizer(target:self, action: "gotoNextView2:")
//            v.addGestureRecognizer(vr)
//            
//        }
    }
    
    //去下一页的方法
    func gotoNextView1(sender: UITapGestureRecognizer){
        let menuEnum:MenuEnum = Setting.Menus1[(sender.view?.tag)!]
        
        //初始化第二页的控制器
        let nextVC = WebViewController()
        nextVC.urlStr = MenuEnum.getUrl(menuEnum)
        nextVC.showTitle = true
        nextVC.titleStr = MenuEnum.getTitle(menuEnum)
        
        if(MenuEnum.getUrl(menuEnum) == "1")
        {
           let nextVC = InfoController()
            //var gg = NewViewController()
            
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.window!.rootViewController = nextVC
        }else if(MenuEnum.getUrl(menuEnum) == "2"){
            let nextVC = OfficialAnnouncementController()
            //let nextVC = NewViewController()
            //var gg = NewViewController()
            
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.window!.rootViewController = nextVC
        }else if(MenuEnum.getUrl(menuEnum) == "3"){
            //let nextVC = QRCodeController()
            let nextVC = NewViewController()
            var gg = NewViewController()
            
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.window!.rootViewController = nextVC
        }
        
        //显示第二页的控制器
        //self.navigationController?.pushViewController(nextVC, animated: true)
        //.showViewController(nextVC, sender: self)
    }
    
    //去下一页的方法
    func gotoNextView2(sender: UITapGestureRecognizer){
//        let menuEnum:MenuEnum = Setting.Menus2[(sender.view?.tag)!]
//        
//        //初始化第二页的控制器
//        let nextVC = WebViewController()
//        nextVC.urlStr = MenuEnum.getUrl(menuEnum)
//        nextVC.showTitle = true
//        nextVC.titleStr = MenuEnum.getTitle(menuEnum)
//        //显示第二页的控制器
//        
//        let test =  QRCodeController()
//        self.navigationController?.pushViewController(test, animated: true)
        //.showViewController(nextVC, sender: self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

