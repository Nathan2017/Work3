//
//  datecell.swift
//  NBA
//
//  Created by Nathan on 3/29/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class datecell: UICollectionViewCell {
    let label:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .Center
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(18)
        return label
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
       // layer.borderWidth = 0.5
       // layer.borderColor = UIColor.lightGrayColor().CGColor
        addSubview(label)
        label.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        label.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        label.widthAnchor.constraintEqualToAnchor(widthAnchor).active = true
        label.heightAnchor.constraintEqualToAnchor(heightAnchor).active = true
    }
    override var selected: Bool {
        didSet{
            label.textColor = selected ? UIColor.blueColor() : UIColor.lightGrayColor()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
