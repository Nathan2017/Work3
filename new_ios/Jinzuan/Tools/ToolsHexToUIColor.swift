//
//  ToolsHexToUIColor.swift
//  WebView
//
//  Created by Brain Liao on 2016/3/12.
//  Copyright © 2016年 brainliao. All rights reserved.
//

import Foundation
import UIKit
class ToolsHexToUIColor {
    //使用HEX取得UIColor
    static func transToUIColor(rgbValue: Int32)-> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}