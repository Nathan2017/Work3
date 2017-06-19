//
//  CommonAlertViewDelegate.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/13.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//
import UIKit
import Foundation
class CommonAlertViewDelegate : NSObject, UIAlertViewDelegate {
    
    var alertButtonClickProtocol:AlertButtonClickProtocol!
    
    init(alertButtonClickProtocol: AlertButtonClickProtocol) {
        self.alertButtonClickProtocol = alertButtonClickProtocol
        super.init()
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        print("click" + String(buttonIndex))
        if(alertButtonClickProtocol != nil)
        {
            let ac:AlertButtonClickCondition = AlertButtonClickCondition()
            ac.index = buttonIndex
            alertButtonClickProtocol.DoButtonClicks(ac)
        }
        
    }
}
