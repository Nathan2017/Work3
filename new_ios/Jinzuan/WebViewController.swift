//
//  WebViewController.swift
//  WebView
//
//  Created by Brain Liao on 2016/3/3.
//  Copyright © 2016年 brainliao. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    
    var webViewLayout:WebViewLayout!
    
    var urlStr:String!
    
    var titleStr:String!
    
    var showTitle:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webViewLayout = WebViewLayout(frame: self.view.frame,titleStr:titleStr,showTitleView: showTitle )
        let url: NSURL = NSURL(string: urlStr)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        webViewLayout.webView.scalesPageToFit = true
        webViewLayout.webView.loadRequest(request)
        webViewLayout.webView.delegate = self
        self.view.addSubview(webViewLayout)
        self.webViewLayout?.back_btn!.addTarget(self,action:"backView", forControlEvents: .TouchUpInside)
        if(!showTitle){
        UrlAPIDAO.getLinkURL { (str) in
            UrlDAO.insertUrl(str)
        }
        }
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
    
    
    func backView()
    {
        self.webViewLayout.webView.stopLoading()
        if(self.showTitle!){
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            if(self.webViewLayout.webView.canGoBack)
            {
                self.webViewLayout.webView.goBack()
            }
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.webViewLayout.webView.stopLoading()
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
