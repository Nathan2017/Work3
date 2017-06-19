//
//  ViewController.swift
//  calcs
//
//  Created by Nathan on 3/24/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class CalcsController: UIViewController {
    var navheight:CGFloat!
    var mi:UILabel!
    var previousnum:String? = nil
    var currentnum:String? = nil
    var showoperator:UILabel!
    var operatornum:String? = nil
    var currentoperator:String? = nil
    var operatornum2:String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]

       // navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        navheight = 0
        mi = UILabel(frame: CGRect(x: 0, y: navheight, width: view.frame.width, height: view.frame.width/2))
        mi.textAlignment = .Right
        mi.font = UIFont.systemFontOfSize(100)
        mi.backgroundColor = UIColor.grayColor()
        mi.text = "0"
        showoperator = UILabel(frame: CGRect(x: view.frame.width-30, y: 0, width: 30, height: 30))
        showoperator.backgroundColor = UIColor.clearColor()
        showoperator.textAlignment = .Center
        view.addSubview(mi)
        mi.addSubview(showoperator)
        var w:CGFloat = 0
        var h:CGFloat = view.frame.width/2 + navheight
        let wx:CGFloat = view.frame.width/5
        let hy:CGFloat = (view.frame.height - h)/4-28
        for a in 1...9 {
            
            let button = UIButton(frame: CGRect(x: w, y: h, width: wx, height: hy))
            button.setTitle(String(a), forState: .Normal)
            button.layer.borderWidth = 0.5
            button.backgroundColor = UIColor.orangeColor()
            button.addTarget(self, action: #selector(shownumber), forControlEvents: .TouchUpInside)
            view.addSubview(button)
            w += wx
            if a%3 == 0 {
                h += hy
                w = 0
            }
        }
        let button = UIButton(frame: CGRect(x: 0, y: h, width: wx*3, height: hy))
        button.setTitle("0", forState: .Normal)
        button.backgroundColor = UIColor.orangeColor()
        button.addTarget(self, action: #selector(shownumber), forControlEvents: .TouchUpInside)
        button.layer.borderWidth = 0.5
        view.addSubview(button)
        let button1 = UIButton(frame: CGRect(x: wx*3, y: h, width: wx*2, height: hy))
        button1.backgroundColor = UIColor.orangeColor()
        button1.setTitle("=", forState: .Normal)
        button1.layer.borderWidth = 0.5
        button1.addTarget(self, action: #selector(equla), forControlEvents: .TouchUpInside)
        view.addSubview(button1)
        let button2 = UIButton(frame: CGRect(x: wx*4, y: view.frame.width/2+navheight, width: wx, height: hy))
        button2.backgroundColor = UIColor.orangeColor()
        button2.setTitle("CE", forState: .Normal)
        button2.layer.borderWidth = 0.5
        button2.addTarget(self, action: #selector(clear), forControlEvents: .TouchUpInside)
        view.addSubview(button2)
        let button3 = UIButton(frame: CGRect(x: wx*3, y: view.frame.width/2+navheight, width: wx, height: hy))
        button3.backgroundColor = UIColor.orangeColor()
        button3.setTitle("*", forState: .Normal)
        button3.addTarget(self, action: #selector(operation), forControlEvents: .TouchUpInside)
        button3.layer.borderWidth = 0.5
      //  button3.addTarget(self, action: #selector(clear), forControlEvents: .TouchUpInside)
        view.addSubview(button3)
        let button4 = UIButton(frame: CGRect(x: wx*3, y: view.frame.width/2+navheight+hy, width: wx, height: hy))
        button4.backgroundColor = UIColor.orangeColor()
        button4.setTitle("÷", forState: .Normal)
        button4.addTarget(self, action: #selector(operation), forControlEvents: .TouchUpInside)
        button4.layer.borderWidth = 0.5
        //  button3.addTarget(self, action: #selector(clear), forControlEvents: .TouchUpInside)
        view.addSubview(button4)
        let button5 = UIButton(frame: CGRect(x: wx*3, y: view.frame.width/2+navheight+hy+hy, width: wx, height: hy))
        button5.backgroundColor = UIColor.orangeColor()
        button5.setTitle("-", forState: .Normal)
        button5.addTarget(self, action: #selector(operation), forControlEvents: .TouchUpInside)
        button5.layer.borderWidth = 0.5
        //  button3.addTarget(self, action: #selector(clear), forControlEvents: .TouchUpInside)
        view.addSubview(button5)
        let button6 = UIButton(frame: CGRect(x: wx*4, y: view.frame.width/2+navheight+hy, width: wx, height: hy*2))
        button6.backgroundColor = UIColor.orangeColor()
        button6.setTitle("+", forState: .Normal)
        button6.addTarget(self, action: #selector(operation), forControlEvents: .TouchUpInside)
        button6.layer.borderWidth = 0.5
        //  button3.addTarget(self, action: #selector(clear), forControlEvents: .TouchUpInside)
        view.addSubview(button6)
    }
    func shownumber(button:UIButton){
        if(currentoperator == nil)
        {
            if(button.titleLabel?.text == "0" && mi.text == "0")
            {
                operatornum = "0"
                mi.text = "0"
            }
            else
            {
        if(previousnum != nil)
        {
                currentnum = currentnum! + (button.titleLabel?.text)!
            
            previousnum = currentnum

        }
        else
        {
            currentnum = button.titleLabel?.text
            
            previousnum = currentnum
        }
        operatornum = currentnum
        mi.text = currentnum
            }
        }
        else
        {
            
            
            
            if(previousnum != nil)
            {
                
                    currentnum = currentnum! + (button.titleLabel?.text)!
                
                previousnum = currentnum
            }
            else
            {
                currentnum = button.titleLabel?.text
                previousnum = currentnum
            }
            operatornum2 = currentnum
            mi.text = currentnum
            
        }
    }
    func operation(button:UIButton){
        if(operatornum2 != nil)
        {
            switch currentoperator{
                
            case "+"?:   mi.text = String(Int(operatornum!)! + Int(operatornum2!)!)
            case "-"?: mi.text = String(Int(operatornum!)! - Int(operatornum2!)!)
            case "*"?: mi.text = String(Int(operatornum!)! * Int(operatornum2!)!)
            case "÷"?: mi.text = String(Int(operatornum!)! / Int(operatornum2!)!)
            default: break
            }

            showoperator.text = button.titleLabel?.text
            currentoperator = button.titleLabel?.text
            operatornum = mi.text
            previousnum = nil
        }
        else
        {
        showoperator.text = button.titleLabel?.text
        currentoperator = button.titleLabel?.text
        previousnum = nil
        }
        
    }
    func clear()
    {
        previousnum = nil
        currentnum = nil
        operatornum = nil
        operatornum2 = nil
        currentoperator = nil
        showoperator.text = nil
        mi.text = "0"
    }
    func equla(){
        
        if(operatornum != nil && operatornum2 != nil){
            showoperator.text = "="
            switch currentoperator {
            
             case "+"?:   mi.text = String(Int(operatornum!)! + Int(operatornum2!)!)
            case "-"?: mi.text = String(Int(operatornum!)! - Int(operatornum2!)!)
            case "*"?: mi.text = String(Int(operatornum!)! * Int(operatornum2!)!)
            case "÷"?: mi.text = String(Int(operatornum!)! / Int(operatornum2!)!)
            default: break
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

