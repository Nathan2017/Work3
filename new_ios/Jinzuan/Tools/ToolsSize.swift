//
//  ToolsSize.swift
//  WebView
//
//  Created by Brain Liao on 2016/3/12.
//  Copyright © 2016年 brainliao. All rights reserved.
//
import UIKit
import Foundation
/** 計算寬高方法*/
class ToolsSize {
    /**
     計算文字寬度
     @param string 檢測字串
     @param withFont 文字格式
     */
    static func getSizeFromString(string:String, withFont font:UIFont)->CGFloat{
        let textSize = NSString(string: string ?? "").sizeWithAttributes(
            [ NSFontAttributeName:font ])
        return textSize.width
    }
    
    static func getHeightFromLimitWidth(limitWidth:CGFloat,string:String, withFont font:UIFont)->CGFloat{
        var tempLabel:UILabel? = UILabel()
        tempLabel!.font = font
        tempLabel!.text = string
        tempLabel!.frame = CGRectMake(0,0,limitWidth,0)
        tempLabel!.numberOfLines = 0
        tempLabel!.lineBreakMode = .ByWordWrapping
        tempLabel!.sizeToFit()
        let height = tempLabel!.frame.height
        tempLabel = nil
        return height
    }
}
