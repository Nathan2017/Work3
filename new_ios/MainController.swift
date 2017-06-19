//
//  MainController.swift
//  Jinzuan
//
//  Created by Rocky on 2016/7/29.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit
import AirshipKit
class MainController: UIViewController {
    
    weak var scroll: UIScrollView?
    var customView: UIView!
    var c = 0
    var ab: Bool = false
    let AlertOnce = NSUserDefaults.standardUserDefaults()
    let butt = UIButton(type: .Custom)
    var img:NSArray = []
    var newimg: [UIImage] = []
    var queue = NSOperationQueue()
    var downLoadImageCount:Int = 0
    let en = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        UAirship.takeOff()
        
        UAirship.push().userPushNotificationsEnabled = true
        print(UAirship.push().channelID)
        // let otherVC = LaunchViewController()
        // newimg = otherVC.imagearray
        // print(newimg[0])
        //var gc = NSUserDefaults.standardUserDefaults().objectForKey("img1")
        //print(gc)
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        // print(appDelegate.query)
        //print(appDelegate.query)
        if(appDelegate.query != "")
        {
        
           if let keyExist = appDelegate.query.getKeyVals()!["user"]
            {
                let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appdelegate.window!.rootViewController = PushViewController()
            }
            
            
        }
        else
        {
        let langId = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String
        let tempScroll = UIScrollView()
        self.scroll = tempScroll
        self.scroll?.frame = self.view.frame
        let firstView = UIImageView()
        firstView.image = UIImage(named:"eb畫面.jpg")
        firstView.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        /*   let firstView = UIImageView()
         let secondView = UIImageView()
         let thirdView = UIImageView()
         let fourthView = UIImageView()
         let fifthView = UIImageView()*/
        self.scroll?.addSubview(firstView)
        var hi:[UIImageView] = []
        
        var holex:Int = 1
        var jj:CGFloat = 0
       // var url: NSURL = NSURL(string: "http://api.wemeete.com/gwinapi.aspx?station=jinglong&platform=apple1")!
            var url:NSURL = NSURL(string: "")!
        var data: NSData = NSData(contentsOfURL: url)!
        do {
            let lookup = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
            //print(lookup["results"]![0]["version"])
            img = lookup["img"] as! NSArray
            for num in img
            {
                //var hh = "view\(holex)"
                let gg = UIImageView()
                hi.append(gg)
                holex += 1
                
            }
            for (j,k) in zip(hi,img)
            {
                //queue.addOperationWithBlock{ ()-> Void in
                let tr = k as! String
                ImageLoader.sharedLoader.imageForUrl(tr, completionHandler:{(image: UIImage?, url: String) in
                    
                    self.downLoadImageCount = self.downLoadImageCount + 1
                    
                    if(image == nil)
                    {
                        j.image = nil
                    }else
                    {
                        j.image = image
                    }
                    
                    if(self.downLoadImageCount == self.img.count){
                        firstView.hidden = true
                        self.en.setTitle("进入主页", forState: .Normal)
                        self.en.frame = CGRectMake(self.view.frame.width-150, self.view.frame.height-100, 150, 150)
                        self.en.titleLabel!.font = UIFont(name: "MicrosoftYaHei-Bold",size: 30)
                        self.en.setTitleColor(UIColor(red:252, green:194, blue: 0, alpha: 1.0),forState: .Normal)
                        let timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "update", userInfo: nil, repeats: true)
                    }
                })
                
                
                
                
                //                    if let url = NSURL(string: tr)
                //                    {
                //                        //queue.addOperationWithBlock{ ()-> Void in
                //                        if let data = NSData(contentsOfURL: url)
                //                        {
                //                          //  NSOperationQueue.mainQueue().addOperationWithBlock({
                //                            j.image = UIImage(data: data)
                //                            //    })
                //
                //
                //                        }
                //                        //}
                //                    }
                j.frame = CGRectMake(jj,0,self.view.frame.width,self.view.frame.height)
                self.scroll?.addSubview(j)
                jj += self.view.frame.width
                //  }
            }
            
        } catch {
            print("json error: \(error)")
        }
        /*let en = UIButton()
         if(langId=="en")
         {
         en.setTitle("Enter Main Menu",forState: .Normal)
         
         en.titleLabel!.font = UIFont(name: "MicrosoftYaHei-Bold",size: 20)
         en.frame = CGRectMake(self.view.frame.width-200, self.view.frame.height-100, 200, 180)
         }
         else
         {
         en.setTitle("进入主页", forState: .Normal)
         en.frame = CGRectMake(self.view.frame.width-150, self.view.frame.height-100, 150, 150)
         en.titleLabel!.font = UIFont(name: "MicrosoftYaHei-Bold",size: 30)
         }
         en.setTitleColor(UIColor(red:252, green:194, blue: 0, alpha: 1.0),forState: .Normal)*/
        
        
        
        en.addTarget(self,action: "butact:", forControlEvents: .TouchDown)
        
        scroll!.contentSize=CGSizeMake(self.view.frame.width*CGFloat(img.count),self.view.frame.height)
        scroll!.pagingEnabled = true
        scroll!.scrollEnabled = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.alwaysBounceHorizontal = true
        self.view.addSubview(scroll!)
        self.view.addSubview(en)
        
        
        
        //   let timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "update", userInfo: nil, repeats: true)
        
        
        
        }
        
    }
    func update()
    {
        let offset = scroll?.contentOffset
        
        if(c < img.count)
        {
            scroll?.setContentOffset(CGPoint(x: offset!.x + view.frame.width, y: offset!.y ), animated: false)
            if(scroll?.contentOffset.x >= view.frame.width*CGFloat(img.count))
            {
                scroll?.setContentOffset(CGPoint(x: 0, y: offset!.y), animated: false)
            }
            c+=1
            
        }
        if(c==img.count)
        {
            let logoViewController:LogoViewController  = LogoViewController()
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.window!.rootViewController = logoViewController
        }
    }
    func butact(sender: UIButton)
    {
        let logoViewController:LogoViewController  = LogoViewController()
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.window!.rootViewController = logoViewController
        
    }
    
    
    
}
