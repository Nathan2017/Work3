//
//  LaunchViewController.swift
//  Nathan
//
//  Created by Rocky on 2016/9/13.
//  Copyright © 2016年 Nathan. All rights reserved.
//

import UIKit
extension String {
    func getKeyVals() -> Dictionary<String, String>? {
        var results = [String:String]()
        let keyValues = self.componentsSeparatedByString("&")
        if keyValues.count > 0 {
            for pair in keyValues {
                let kv = pair.componentsSeparatedByString("=")
                if kv.count > 1 {
                    results.updateValue(kv[1], forKey: kv[0])
                }
            }
            
        }
        return results
    }
}
class LaunchViewController: UIViewController {
    var blinkstatus:Bool = false
    var cc = UILabel()
    var img: NSArray = []
    var downLoadImageCount:Int = 0
    var imagearray:[UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let langId = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String
        var de = NSUserDefaults.standardUserDefaults()
        var fs:[String] = []
        de.setObject(fs, forKey: "fs")
        
        de.synchronize()
        var nn = NSUserDefaults.standardUserDefaults()
        var db:[String] = []
        nn.setObject(db, forKey: "db")
        nn.synchronize()
        let firstView = UIImageView()
        firstView.contentMode = .ScaleAspectFill
        firstView.clipsToBounds = true
        firstView.image = UIImage(named:"eb畫面.png")
        firstView.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        
        cc.text = "下載中 ....."
        cc.font = UIFont(name:"MicrosoftYaHei-Bold",size: 30)
        cc.textColor = UIColor.yellowColor()
        cc.frame = CGRectMake((self.view.frame.width-150)/2,(self.view.frame.height-150)/2,150,150)
        
        firstView.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        
        self.view.addSubview(firstView)
        // self.view.addSubview(cc)
        /* var hi:[UIImageView] = []
         var holex:Int = 1
         var jj:CGFloat = 0
         var data: NSData = NSData(contentsOfURL: url)!
         do {
         let lookup = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
         //print(lookup["results"]![0]["version"])
         img = lookup["img"] as! NSArray
         
         for k in img
         {
         //queue.addOperationWithBlock{ ()-> Void in
         let tr = k as! String
         
         ImageLoader.sharedLoader.imageForUrl(tr, completionHandler: {(image:UIImage?,url:String) in
         self.downLoadImageCount = self.downLoadImageCount + 1
         if(image == nil)
         {
         print("image is nil")
         }
         else
         {
         self.imagearray.append(image!)
         }
         if(self.downLoadImageCount == self.img.count)
         {
         var defaults = NSUserDefaults.standardUserDefaults()
         var ic = 1
         for i in self.imagearray
         {
         defaults.setObject(UIImagePNGRepresentation(i), forKey: "img\(ic)")
         ic += 1
         }
         //self.checkVersion()
         }
         /* if(self.downLoadImageCount == self.img.count)
         {
         self.checkVersion()
         let timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "update", userInfo: nil, repeats: true)
         
         }*/
         })
         /*if let url = NSURL(string: tr)
         {
         //queue.addOperationWithBlock{ ()-> Void in
         if let data = NSData(contentsOfURL: url)
         {
         //  NSOperationQueue.mainQueue().addOperationWithBlock({
         j.image = UIImage(data: data)
         //    })
         j.frame = CGRectMake(jj,0,self.view.frame.width,self.view.frame.height)
         self.scroll?.addSubview(j)
         
         }
         //}
         }*/
         //jj += self.view.frame.width
         //  }
         }
         
         } catch {
         print("json error: \(error)")
         }*/
        // Do any additional setup after loading the view.
        self.doContinueAlert()
        //  print(imagearray[0])
    }
    
    /*  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
     
     }*/
    func update(){
        if(blinkstatus == false){
            cc.backgroundColor = UIColor.whiteColor()
            print(blinkstatus)
            blinkstatus = true
        }
        else
        {
            cc.backgroundColor = UIColor.blackColor()
            print(blinkstatus)
            blinkstatus = false
        }
    }
    func doUpdateVersion(){
        dispatch_async(dispatch_get_main_queue()) {
            let hongjing =  UIAlertController(title:"有新版本", message: "請更新到最新版本", preferredStyle: .Alert)
            let no = UIAlertAction(title: "确定", style: .Default, handler: self.kk)
            hongjing.addAction(no)
            self.presentViewController(hongjing, animated: true, completion: nil)
        }
    }
    func kk(no: UIAlertAction)
    {
    
    }
    func doContinueAlert(){
        dispatch_async(dispatch_get_main_queue()) {
            if(ToolsString.isEmpty(UrlDAO.getUrl())){
                
                let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appdelegate.window!.rootViewController = TabController()
            }else
            {
                
                
                let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appdelegate.window!.rootViewController = MainController()
            }
        }
    }
    func checkVersion(){
        VersionAPIDAO.getVersion({ (result) in
            //執行成功,需檢測版本
            let nsObject: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
            
            let currentVersion = nsObject as! String
            do {
                let data: NSData = result.dataUsingEncoding(NSUTF8StringEncoding)!
                let lookup = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
                
                let appStoreVersion = (lookup["version"]) as! NSNumber
                let newver = "\(appStoreVersion)"
                if newver != currentVersion {
                    //更新版本
                    print(appStoreVersion)
                    self.doUpdateVersion()
                    return
                    
                }
                
            } catch {
                print("json error: \(error)")
            }
            //檢測不需更新便繼續動作
            self.doContinueAlert();
            
            })
        { (error) in
            //執行失敗
            //便繼續動作
            self.doContinueAlert();
            
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
