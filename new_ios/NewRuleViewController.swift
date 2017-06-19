//
//  NewRuleViewController.swift
//  Nathan
//
//  Created by Rocky on 11/23/16.
//  Copyright © 2016 Nathan. All rights reserved.
//

import UIKit

class NewRuleViewController: UIViewController{
    var t: UILabel!
    var t2: UILabel!
    
    var t6: UINavigationBar!
    var editrule:String!
    var editname:String!
    var locate:Int!
    lazy var t4: UITextView = {
        let t4 = UITextView()
        t4.frame = CGRectMake(50,200,self.view.frame.width-100,300)
        //t4.translatesAutoresizingMaskIntoConstraints = false
       // print(self.editrule)
        if let mm = self.editrule{
            print(self.editrule)
            t4.text = mm
        }
        t4.layer.borderWidth = 1.0
        t4.layer.borderColor = UIColor.blackColor().CGColor
        t4.layer.cornerRadius = 25
        t4.font = UIFont(name: "Helvetica Neue", size: 20)
        return t4
    }()
    lazy var t3: UITextView = {
        let t3 = UITextView()
        t3.frame = CGRectMake(50,80,self.view.frame.width-100,50)
        //t3.placeholder = "Enter Rule Name"
        // t3.delegate = self
    
        if let md = self.editname{
            print(self.editname)
            t3.text = md
        }
        t3.font = UIFont(name: "Helvetica Neue", size: 20)
        t3.resignFirstResponder()
        t3.layer.borderWidth = 1.0
        t3.layer.borderColor = UIColor.blackColor().CGColor
        t3.layer.cornerRadius = 10
        return t3
    }()
    lazy var t5: UIButton = {
        let t5 = UIButton()
      
        t5.setTitle("完成編輯", forState: .Normal)
        
    
        t5.setTitleColor(UIColor.blueColor(), forState: .Normal)
        t5.layer.borderWidth = 1.0
        t5.layer.cornerRadius = 25
        t5.addTarget(self, action: "new:", forControlEvents: .TouchUpInside)
        return t5
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let c = NewViewController()
        c.c = self
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
       /* t6 = UINavigationBar()
        t6.frame = CGRectMake(0,0,self.view.frame.width,75)
        t6.barTintColor = UIColor.grayColor()*/
       // var backbutton = UIButton(frame: CGRectMake(0,(t6.frame.height)/2,50,50))
       // backbutton.setImage(UIImage(named: "back_c"), forState: .Normal)
       // backbutton.addTarget(self, action: "bb:", forControlEvents: .TouchUpInside)
       // var backBarButton = UIBarButtonItem(customView: backbutton)
       // let cc = UINavigationItem()
       // cc.leftBarButtonItem = backBarButton
       // t6.setItems([cc], animated: false)
        t = UILabel()
        t.frame = CGRectMake(50,0,150,100)
        t.text = "规则名称"
        t.textColor = UIColor.blackColor()
        t2 = UILabel()
        t2.frame = CGRectMake(50,120,150,100)
        t2.text = "规则讲解"
        
       // t4.delegate = self
       
        var ii = UITapGestureRecognizer(target: self, action: "Di:")
        t5.frame = CGRectMake((self.view.frame.width-100)/2,self.t.frame.height+self.t2.frame.height+self.self.t3.frame.height+self.t4.frame.height-20,100,50)
       // view.addSubview(t6)
        view.addSubview(t)
        view.addSubview(t2)
        view.addSubview(t3)
        view.addSubview(t4)
        view.addSubview(t5)
               view.addGestureRecognizer(ii)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func Di(sender:UITapGestureRecognizer)
    {
        t3.resignFirstResponder()
        t4.resignFirstResponder()
    }
    func bb(sender:UIButton)
    {
        //var gg = NewViewController()
       /* var gg = NewViewController()
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.window!.rootViewController = gg*/
        navigationController?.popViewControllerAnimated(true)
    }
    func new(sender:UIButton)
    {
        t3.resignFirstResponder()
        t4.resignFirstResponder()
        if(t3.text == "")
        {
            var alert = UIAlertView(title: "", message: "Please Enter Rule Name", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if(t4.text == "")
        {
            var alert = UIAlertView(title: "", message: "Please Enter Rule Description", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else
        {
            if(locate != nil)
            {
                var def = NSUserDefaults.standardUserDefaults()
                var rr = def.objectForKey("fs") as! [String]
                rr[locate] = t3.text!
                var ef = NSUserDefaults.standardUserDefaults()
                var dwe = ef.objectForKey("db") as! [String]
                dwe[locate] = t4.text!
                def.setObject(rr, forKey: "fs")
                def.synchronize()
                ef.setObject(dwe, forKey: "db")
                ef.synchronize()
                
               /* var gg = NewViewController()
                
                let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appdelegate.window!.rootViewController = gg*/
                navigationController?.popViewControllerAnimated(true)
            }
            else
            {
            var def = NSUserDefaults.standardUserDefaults()
            var rr = def.objectForKey("fs") as! [String]
            rr.append(t3.text!)
            def.setObject(rr, forKey: "fs")
            def.synchronize()
            var ef = NSUserDefaults.standardUserDefaults()
            var dwe = ef.objectForKey("db") as! [String]
            dwe.append(t4.text!)
            ef.setObject(dwe, forKey: "db")
            ef.synchronize()
          /*  var gg = NewViewController()
    
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.window!.rootViewController = gg*/
                navigationController?.popViewControllerAnimated(true)
            }
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
