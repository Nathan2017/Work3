//
//  collectview.swift
//  NBA
//
//  Created by Nathan on 3/28/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class collectview: UICollectionViewCell {
    let label1:UILabel = {
       let l1 = UILabel()
        l1.translatesAutoresizingMaskIntoConstraints = false
        return l1
    }()
    let label2:UILabel  = {
       let l2 = UILabel()
        l2.translatesAutoresizingMaskIntoConstraints  = false
        l2.text = "VS"
        l2.textAlignment = .Center
        return l2
        
    }()
    let label3:UILabel  = {
        let l2 = UILabel()
        l2.translatesAutoresizingMaskIntoConstraints  = false
        //l2.text = "VS"
        //l2.textAlignment = .Center
        l2.textAlignment = .Center
        return l2
        
    }()
    let label4:UILabel  = {
        let l2 = UILabel()
        l2.translatesAutoresizingMaskIntoConstraints  = false
        //l2.text = "VS"
        //l2.textAlignment = .Center
       // l2.textAlignment = .Center
        return l2
        
    }()
    let label5:UILabel  = {
        let l2 = UILabel()
        l2.translatesAutoresizingMaskIntoConstraints  = false
        //l2.text = "VS"
        //l2.textAlignment = .Center
        l2.textAlignment = .Right
        return l2
        
    }()
    let label6:UILabel  = {
        let l2 = UILabel()
        l2.translatesAutoresizingMaskIntoConstraints  = false
        //l2.text = "VS"
        //l2.textAlignment = .Center
        l2.textAlignment = .Center
        l2.textColor = UIColor.redColor()
        return l2
        
    }()
    let label8:UILabel  = {
        let l2 = UILabel()
        l2.translatesAutoresizingMaskIntoConstraints  = false
        //l2.text = "VS"
        //l2.textAlignment = .Center
       l2.textAlignment = .Left
        l2.text = "客隊"
        return l2
        
    }()
    let label7:UILabel  = {
        let l2 = UILabel()
        l2.translatesAutoresizingMaskIntoConstraints  = false
        //l2.text = "VS"
        //l2.textAlignment = .Center
        l2.textAlignment = .Right
        l2.text = "主隊"
        return l2
        
    }()
    let timelabel:UILabel = {
       let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .Center
        //tl.text = nil
        return tl
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 0.5
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        addSubview(label4)
        addSubview(label5)
        addSubview(label6)
        addSubview(label7)
        addSubview(label8)
        addSubview(timelabel)
        label1.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        label1.leftAnchor.constraintEqualToAnchor(leftAnchor,constant: 20).active = true
        label1.widthAnchor.constraintEqualToConstant(130).active = true
        label1.heightAnchor.constraintEqualToAnchor(heightAnchor, multiplier: 1/3).active = true
        label2.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        label2.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        label2.heightAnchor.constraintEqualToAnchor(heightAnchor, multiplier: 1/3).active = true
        label2.widthAnchor.constraintEqualToConstant(50).active = true
       
        label3.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        label3.rightAnchor.constraintEqualToAnchor(rightAnchor,constant: -10).active = true
        label3.widthAnchor.constraintEqualToConstant(130).active = true
        label3.heightAnchor.constraintEqualToAnchor(heightAnchor, multiplier: 1/3).active = true
        
        label4.centerXAnchor.constraintEqualToAnchor(label1.centerXAnchor).active = true
        label4.topAnchor.constraintEqualToAnchor(label1.bottomAnchor).active = true
        label4.widthAnchor.constraintEqualToConstant(50).active = true
        label4.heightAnchor.constraintEqualToConstant(30).active = true
        
        label5.centerXAnchor.constraintEqualToAnchor(label3.centerXAnchor).active = true
        label5.topAnchor.constraintEqualToAnchor(label3.bottomAnchor).active = true
        label5.widthAnchor.constraintEqualToConstant(50).active = true
        label5.heightAnchor.constraintEqualToConstant(30).active = true
        
        label6.bottomAnchor.constraintEqualToAnchor(label2.topAnchor).active = true
        label6.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        label6.heightAnchor.constraintEqualToConstant(30).active = true
        label6.widthAnchor.constraintEqualToConstant(100).active = true
        
        label8.centerXAnchor.constraintEqualToAnchor(label1.centerXAnchor,constant: -10).active = true
        label8.bottomAnchor.constraintEqualToAnchor(label1.topAnchor).active = true
        label8.widthAnchor.constraintEqualToConstant(50).active = true
        label8.heightAnchor.constraintEqualToConstant(30).active = true

        label7.centerXAnchor.constraintEqualToAnchor(label3.centerXAnchor).active = true
        label7.bottomAnchor.constraintEqualToAnchor(label3.topAnchor).active = true
        label7.widthAnchor.constraintEqualToConstant(50).active = true
        label7.heightAnchor.constraintEqualToConstant(30).active = true
        
        timelabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        timelabel.topAnchor.constraintEqualToAnchor(label2.bottomAnchor).active = true
        timelabel.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        timelabel.widthAnchor.constraintEqualToConstant(100).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
