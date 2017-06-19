//
//  ShowViewController.swift
//  Nathan
//
//  Created by Nathan on 3/20/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    let imagview:UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "show.jpg")
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.orangeColor()
        return iv
        
    }()
    lazy var button:UIButton = {
        let butt = UIButton(type: UIButtonType.System)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("進入申博138", forState: .Normal)
        butt.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        butt.backgroundColor = UIColor(red: 150/255, green: 134/255, blue: 50/255, alpha: 1)
        butt.addTarget(self, action: #selector(enter), forControlEvents: .TouchUpInside)
        return butt
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imagview)
        view.addSubview(button)
        imagview.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        imagview.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        imagview.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        imagview.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 3.5/4).active = true
        
        button.topAnchor.constraintEqualToAnchor(imagview.bottomAnchor).active = true
        button.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        button.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        button.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.5/4).active = true
    }
    func enter(){
        self.presentViewController(TabController(), animated: false, completion: nil)
    }

}
