//
//  MenuEnum.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/3/26.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

enum MenuEnum {
    case Test1,
    Test2,
   Test3
//    ,
//    Test4,
//    Test5,
//    Test6
    
    static func getTitle(menuEnum:MenuEnum) ->String
    {
        if(MenuEnum.Test1 == menuEnum){
            return "高尔夫規則"
        }else if(MenuEnum.Test2 == menuEnum){
            return "系统讯息"
        }
        else if(MenuEnum.Test3 == menuEnum){
            return "增加自订规则"
        }
//        else if(MenuEnum.Test4 == menuEnum){
//            return "在线客服"
//        }
//        else if(MenuEnum.Test5 == menuEnum){
//            return "联络我们"
//        }
//        else if(MenuEnum.Test6 == menuEnum){
//            return ""
//        }
        return ""
    }
    
    static func getUrl(menuEnum:MenuEnum)->String
    {
        if(MenuEnum.Test1 == menuEnum){
            return "1"
        }else if(MenuEnum.Test2 == menuEnum){
            return "2"
        }
        else if(MenuEnum.Test3 == menuEnum){
            return "3"
        }
//        else if(MenuEnum.Test4 == menuEnum){
//            return "http://messenger.providesupport.com/messenger/16c6t88ugk0mn1fr2udyeepk50.html"
//        }
//        else if(MenuEnum.Test5 == menuEnum){
//            return "http://www.op828.com/app/contact.html"
//        }
//        else if(MenuEnum.Test6 == menuEnum){
//            return "http://www.buzzhand.com/post_345144.html?t=22820"
//        }
        return ""
    }
    
    static func getPhotoPath(menuEnum:MenuEnum) ->String
    {
        if(MenuEnum.Test1 == menuEnum){
            return "ic1"
        }else if(MenuEnum.Test2 == menuEnum){
            return "i_company_announce"
        }
        else if(MenuEnum.Test3 == menuEnum){
            return "ii"
        }
//        else if(MenuEnum.Test4 == menuEnum){
//            return "test4"
//        }
//        else if(MenuEnum.Test5 == menuEnum){
//            return "test5"
//        }
//        else if(MenuEnum.Test6 == menuEnum){
//            return "test6"
//        }
                return ""
    }
}
