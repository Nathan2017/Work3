//
//  NewViewController.swift
//  Nathan
//
//  Created by Rocky on 11/23/16.
//  Copyright © 2016 Nathan. All rights reserved.
//

import UIKit

class NewViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var u: UITableView!
    var d: [String] = []
    var ee: UINavigationBar!
    var ff: [String] = []
   var c:NewRuleViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        var deee = NSUserDefaults.standardUserDefaults()
        var gh = deee.objectForKey("fs") as! [String]
        var gv = deee.objectForKey("db") as! [String]
        print(gh)
        print(gv)
       // ee = UINavigationBar()
       // ee.frame = CGRectMake(0,0,self.view.frame.width,100)
       // ee.barTintColor = UIColor.grayColor()
        u = UITableView()
        u.separatorStyle = .None
        
        u.frame = CGRectMake(0,5,self.view.frame.width,self.view.frame.height)
        u.dataSource = self
        u.delegate = self
        if(d.count != 0)
        {
            u.reloadData()
        }
       // view.addSubview(ee)
        navigationItem.title = "增加自订规则"
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "selector:")
        let cameraItem = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: #selector(camera2))
        
        navigationItem.rightBarButtonItems = [cameraItem,doneItem]
        let uiimage = UIImage(named: "info.png")?.imageWithRenderingMode(.AlwaysOriginal)
        let infoitem = UIBarButtonItem(image: uiimage, style: .Bordered, target: self, action: #selector(addCategory))
        navigationItem.leftBarButtonItem = infoitem
     //   navItem.leftBarButtonItem = backBarButton
      //  navigationItem.setItems([navItem], animated: false)
            view.addSubview(u)
        // Do any additional setup after loading the view.
    }
    func camera2(){
        self.presentViewController(camera(), animated: true, completion: nil)
    }
    func addCategory() {
        
        self.navigationController?.pushViewController(ExplainController(), animated: true)
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func bb(sender:UIButton)
    {
        var gg = ViewController()
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.window!.rootViewController = gg
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var deee = NSUserDefaults.standardUserDefaults()
        //var fd = deee.objectForKey("fs") as! [String]
        var dr = deee.objectForKey("db") as! [String]
        //fd.removeAtIndex(indexPath.row)
        //dr.removeAtIndex(indexPath.row)
        //deee.setObject(fd, forKey: "fs")
        //deee.setObject(dr, forKey: "db")
        //deee.synchronize()
        if(dr.count == 0)
        {
            return 0
        }
        return 1
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        u.reloadData()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var deee = NSUserDefaults.standardUserDefaults()
        var fd = deee.objectForKey("fs") as! [String]
        var dr = deee.objectForKey("db") as! [String]
        c = NewRuleViewController()
       // c.t5.setTitle("完成編輯", forState: .Normal)
        c.editrule = dr[indexPath.section]
        c.editname = fd[indexPath.section]
        c.locate = indexPath.section
        //c.changetitle()
       // c.t4.text = dr[indexPath.section]
        
        
        
       /* let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.window!.rootViewController = c*/
        navigationController?.pushViewController(c, animated: true)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var deee = NSUserDefaults.standardUserDefaults()
        var gh = deee.objectForKey("fs") as! [String]
        var gv = deee.objectForKey("db") as! [String]
        if(gv.count == 0)
        {
            return 0
        }
        return gh.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = UITableViewCell(style: .Subtitle, reuseIdentifier: "KING")
        var deee = NSUserDefaults.standardUserDefaults()
      //  var gh = deee.objectForKey("fs") as! [String]
        var gv = deee.objectForKey("db") as! [String]
        c.textLabel!.text = gv[indexPath.section]
        c.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        c.textLabel?.numberOfLines = 0
        return c
    }
    func selector(sender:UIBarButtonSystemItem)
    {
        //let nextVC = NewRuleViewController()
        /*var gg = NewRuleViewController()
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       appdelegate.window!.rootViewController = gg*/
        navigationController?.pushViewController(NewRuleViewController(), animated: true)

      //  self.presentViewController(gg, animated: false, completion: nil)
    }
   // func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     //   return true
   // }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete)
        {
            var deee = NSUserDefaults.standardUserDefaults()
            var fd = deee.objectForKey("fs") as! [String]
            var dr = deee.objectForKey("db") as! [String]
            fd.removeAtIndex(indexPath.section)
            dr.removeAtIndex(indexPath.section)
            deee.setObject(fd, forKey: "fs")
            deee.setObject(dr, forKey: "db")
            deee.synchronize()
            
          //  u.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
          //  u.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Fade)
            u.reloadData()
        }
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var deee = NSUserDefaults.standardUserDefaults()
        var gh = deee.objectForKey("fs") as! [String]
       // var gv = deee.objectForKey("db") as! [String]
        return gh[section]
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
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
