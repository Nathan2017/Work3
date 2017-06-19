//
//  UrlRep.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/1.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import Foundation
class UrlRep:Mappable {
    /**companyCode*/
    var result:String!
    
    init() {}
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    
    func mapping(map: Map) {
        result <- map["result"]
        
    }
    
}

