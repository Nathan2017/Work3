//
//  LogoViewController.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/2.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit

class LogoViewController: UIViewController{
    
    var logoLayout:LogoLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        logoLayout = LogoLayout(frame: self.view.frame)
        self.view.addSubview(logoLayout);
        initTap();
        UrlAPIDAO.getLinkURL { (str) in
            if(str != UrlDAO.getUrl()){
            UrlDAO.insertUrl(str)
            self.openLink(str)
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(!ToolsString.isEmpty(UrlDAO.getUrl())){
        self.openLink(UrlDAO.getUrl()!);
        }
    }
    
    func initTap (){
        logoLayout.logo.userInteractionEnabled = true
        let vr = UITapGestureRecognizer(target:self, action: "gotoUrl:")
        logoLayout.logo.addGestureRecognizer(vr)
    }
    
    func openLink(str:String){
        dispatch_async(dispatch_get_main_queue(),{
            if let checkURL = NSURL(string: UrlDAO.getUrl()!) {
                if UIApplication.sharedApplication().openURL(checkURL) {
                    
                }
            }
        });
    }
    
    //去下一页的方法
    func gotoUrl(sender: UITapGestureRecognizer){
        if(!ToolsString.isEmpty(UrlDAO.getUrl()))
        {
            openLink(UrlDAO.getUrl()!);
            
        }
    }
    
    
    
}
