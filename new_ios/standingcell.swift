//
//  File.swift
//  Standing
//
//  Created by Nathan on 3/29/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class standingcell: UICollectionViewCell {
    let view1:UIView = {
       let view1 = UIView()
       // view1.translatesAutoresizingMaskIntoConstraints = false
        view1.backgroundColor = UIColor.blueColor()
        return view1
        
    }()
    let activity:UIActivityIndicatorView = {
       let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
       // activity.startAnimating()
        return activity
    }()
    let label:UILabel = {
       let label = UILabel()
      //  label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "東區"
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        return label
    }()
    let view2:UIView = {
        let view1 = UIView()
        // view1.translatesAutoresizingMaskIntoConstraints = false
        view1.backgroundColor = UIColor.lightGrayColor()
        return view1
        
    }()
    let ranklabel:UILabel = {
        let label = UILabel()
        //  label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "排名"
       // label.textColor = UIColor.whiteColor()
        //label.textAlignment = .Center
        return label
        
    }()
    let namelabel:UILabel = {
        
        let label = UILabel()
        //  label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "隊伍"
     //   label.textColor = UIColor.whiteColor()
      //  label.textAlignment = .Center
        return label
    }()
    var pond:[UILabel] = []
   // var pp:[UILabel] = []
   override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view1)
        addSubview(view2)
        addSubview(activity)
        view1.addSubview(label)
        view2.addSubview(ranklabel)
        view2.addSubview(namelabel)
        view1.frame = CGRectMake(0, 0, frame.width, frame.height/15)
        label.frame = view1.frame
        view2.frame = CGRectMake(0, label.frame.height, frame.width, frame.height/15)
        ranklabel.frame = CGRectMake(10, 0, frame.width/2, frame.height/15)
        namelabel.frame = CGRectMake(frame.width/2, 0, frame.width/2, frame.height/15)
        activity.frame = CGRectMake(frame.width/2, frame.height/2, 100, 100)
 /*   view1.topAnchor.constraintEqualToAnchor(topAnchor).active = true
    view1.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
    view1.heightAnchor.constraintEqualToAnchor(heightAnchor, multiplier: 1/5).active = true
    view1.widthAnchor.constraintEqualToAnchor(widthAnchor).active = true
        label.topAnchor.constraintEqualToAnchor(view1.topAnchor).active = true
        label.leftAnchor.constraintEqualToAnchor(view1.leftAnchor).active = true
        label.heightAnchor.constraintEqualToAnchor(view1.heightAnchor).active = true
        label.widthAnchor.constraintEqualToAnchor(view1.widthAnchor).active = true*/
    var md = frame.height/15*2
    var mc = frame.height/15*2
    for i in 1...15 {
        
        let labelstanding = UILabel(frame: CGRect(x: 15, y: md, width: frame.width, height: frame.height/17))
        labelstanding.text = String(i)
        addSubview(labelstanding)
        md += frame.height/17
        //labelstanding
        
    }
    for i in 1...15 {
        
        let labelstanding = UILabel(frame: CGRect(x: frame.width/2, y: mc, width: frame.width, height: frame.height/17))
        //labelstanding.text = String(i)
        addSubview(labelstanding)
        mc += frame.height/17
        //labelstanding
        self.pond.append(labelstanding)
    }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
