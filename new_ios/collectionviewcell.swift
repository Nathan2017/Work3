//
//  collectionviewcell.swift
//  Nathan
//
//  Created by Nathan on 3/17/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class collectionviewcell: UICollectionViewCell {
    let image:UIImageView = {
       let im = UIImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        im.backgroundColor = UIColor.whiteColor()
        im.contentMode = .ScaleAspectFit
        //im.image = UIImage(named: "im1.jpg")
        im.clipsToBounds = true
        return im
    }()
    let container:UIView = {
       let cn = UIView()
        cn.translatesAutoresizingMaskIntoConstraints = false
        cn.backgroundColor = UIColor.whiteColor()
        return cn
        
    }()
    let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
      //  label.text = "HI"
        label.font = UIFont(name: "Arial-MT" , size: 50)
        label.textAlignment = .Center
        return label
        
    }()
    let seperator:UIView = {
       let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = UIColor.lightGrayColor()
        
        return sep
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        addSubview(container)
        addSubview(seperator)
        container.addSubview(label)
        image.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        image.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        image.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        image.heightAnchor.constraintEqualToAnchor(heightAnchor, multiplier: 3.3/4).active = true
        
        container.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        container.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        container.topAnchor.constraintEqualToAnchor(image.bottomAnchor).active = true
        container.heightAnchor.constraintEqualToAnchor(heightAnchor, multiplier: 0.7/4).active = true
        
        label.centerXAnchor.constraintEqualToAnchor(container.centerXAnchor).active = true
        label.topAnchor.constraintEqualToAnchor(container.topAnchor,constant: 10).active = true
        label.widthAnchor.constraintEqualToAnchor(container.widthAnchor).active = true
        label.heightAnchor.constraintEqualToConstant(50).active = true
        
        seperator.topAnchor.constraintEqualToAnchor(container.topAnchor).active = true
        seperator.widthAnchor.constraintEqualToAnchor(widthAnchor).active = true
        seperator.heightAnchor.constraintEqualToConstant(0.5).active = true
        seperator.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
