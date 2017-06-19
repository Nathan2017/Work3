//
//  ViewController.swift
//  NBA
//
//  Created by Nathan on 3/28/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class GameController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let image:UIImageView = {
       let im = UIImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        im.image = UIImage(named: "jik.jpeg")
        im.backgroundColor = UIColor.clearColor()
        im.contentMode = .ScaleAspectFill
        im.clipsToBounds = true
        return im
    }()
    lazy var collectionview:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.registerClass(collectview.self, forCellWithReuseIdentifier: "cellid")
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceVertical = true
        cv.backgroundColor = UIColor.whiteColor()
       // cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return cv
    }()
    lazy var collectionview2:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.registerClass(datecell.self, forCellWithReuseIdentifier: "cellid2")
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.whiteColor()
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        return cv
        
    }()
    let activity:UIActivityIndicatorView = {
       let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activity.backgroundColor = UIColor.blackColor()
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
        
    }()
    var daate:[[Int]] = []
    var lastmonth:NSDate!
    var jd:NSArray = []
    var pint:[String] = []
    var gameid:[String] = []
    var awaypoint:[String] = []
    var homepoint:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...14
        {
            awaypoint.append("0")
            homepoint.append("0")
        }
        navigationItem.title = "NBA比分"
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        var today = NSDate()
        let calender = NSCalendar.currentCalendar()
        
        let year = calender.component(.Year, fromDate: today)
        var month = calender.component(.Month, fromDate: today)
        var day = calender.component(.Day, fromDate: today)
        
       // print(yesterday)
        let dm = day
        let tomorrow = calender.dateByAddingUnit(.Day, value: 1, toDate: today, options: [])
        day = calender.component(.Day, fromDate: tomorrow!)
        print(day)
        if(day == 1)
        {
            let nextmonth = calender.dateByAddingUnit(.Month, value: 1, toDate: today, options: [])
            month = calender.component(.Month, fromDate: nextmonth!)
        }

        for g in 0...4 {
            
            daate.append([year,month,day])
            if(day == 1)
            {
                day = 31
                month -= 1
            }
            else
            {
                day -= 1
            }
            
        }
        
        print(daate)
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(image)
        view.addSubview(collectionview2)
        view.addSubview(collectionview)
        view.addSubview(activity)
        image.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        image.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        image.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        image.heightAnchor.constraintEqualToConstant(80).active = true
        collectionview2.topAnchor.constraintEqualToAnchor(image.bottomAnchor,constant:10).active = true
        collectionview2.leftAnchor.constraintEqualToAnchor(view.leftAnchor,constant: -10).active = true
        collectionview2.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        collectionview2.heightAnchor.constraintEqualToConstant(50).active = true
        collectionview.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        collectionview.topAnchor.constraintEqualToAnchor(collectionview2.bottomAnchor).active = true
        collectionview.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        collectionview.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        
        activity.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        activity.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        activity.widthAnchor.constraintEqualToConstant(100).active = true
        activity.heightAnchor.constraintEqualToConstant(100).active = true
       
        activity.startAnimating()
        let path = NSIndexPath(forItem: 1, inSection: 0)
        collectionview2.selectItemAtIndexPath(path, animated: false, scrollPosition: UICollectionViewScrollPosition.None)
        print(month)
        callapi(daate[1][0],month: daate[1][1],day: daate[1][2])
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionview
        {
        return jd.count
        }
        else if collectionView == self.collectionview2
        {
            return 5
        }
        else
        {
            return 0
        }
    }
    func callapi(year:Int,month:Int,day:Int){
        var dm = day - 1
        var mc = month
        if(dm == 0)
        {
            dm = 31
            mc -= 1
            
        }
        let ss = "https://api.sportradar.us/nba-t3/zh/games/"+String(year)+"/0"+String(mc)+"/"+String(dm)+"/schedule.json?api_key=pa633fxvmezdkx24c5xwxqjp"
        print(ss)
        let url = NSURL(string: ss)
        let request = NSMutableURLRequest(URL: url!)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                let jj = json["games"] as! NSArray
                 var insertspot = 0
                for i in jj{
                    let mx = i as! NSDictionary
                    if(mx["status"] as! String == "inprogress")
                    {
                      // print("yes")
                        self.callapi2(mx["id"] as! String,insertspot:insertspot)
                        
                    }
              
                    insertspot += 1
                }
                self.jd = jj
                dispatch_async(dispatch_get_main_queue(),{
                    self.activity.stopAnimating()
                    self.activity.hidesWhenStopped = true
                    self.collectionview.reloadData()
                    
                })
                
            }
            catch let error as NSError {
                print(error)
            }
            }.resume()
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.view.layoutIfNeeded()
        self.collectionview2.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        if collectionView == collectionview2
        {
        activity.startAnimating()
        callapi(daate[indexPath.item][0], month: daate[indexPath.item][1], day: daate[indexPath.item][2])
        }
        let ii = NSIndexPath(forItem: 0, inSection: 0)
        self.collectionview.scrollToItemAtIndexPath(ii, atScrollPosition: .Top, animated: false)
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let rr = indexPath.item
        if collectionView == self.collectionview
        {
        let cc = collectionView.dequeueReusableCellWithReuseIdentifier("cellid", forIndexPath: indexPath) as! collectview

             let j1 = jd[indexPath.item]["away"]!!["name"] as! String
             let j2 = jd[indexPath.item]["home"]!!["name"] as! String

             cc.label1.text = j1
             cc.label3.text = j2

        
        switch jd[indexPath.item]["status"] as! String {
        case "closed": cc.label6.text = "結束"
                       cc.label6.textColor = UIColor.redColor()
         cc.timelabel.text = nil
        let j3 = jd[indexPath.item]["away_points"] as! Int
        cc.label4.text = String(j3)
        let j4 = jd[indexPath.item]["home_points"] as! Int
        
        cc.label5.text = String(j4)
        case "complete": cc.label6.text = "結束"
                         cc.label6.textColor = UIColor.redColor()
            let j3 = jd[indexPath.item]["away_points"] as! Int
            cc.label4.text = String(j3)
            let j4 = jd[indexPath.item]["home_points"] as! Int
            
            cc.label5.text = String(j4)
             cc.timelabel.text = nil
        case "inprogress": cc.label6.text = "進行中"
                           cc.label6.textColor = UIColor.greenColor()
           // print(awaypoint,homepoint)
            //print(awaypoint)
            print(indexPath.item)
            cc.label4.text = awaypoint[indexPath.item]
            cc.label5.text = homepoint[indexPath.item]
             cc.timelabel.text = nil
        case "scheduled": cc.label6.text = "還沒開始"
                          cc.label6.textColor = UIColor.magentaColor()
            cc.label4.text = nil
            cc.label5.text = nil
       let formatter = NSDateFormatter()
        var str = jd[indexPath.item]["scheduled"] as! String

        var dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
        dateFor.timeZone = NSTimeZone(abbreviation: "UTC")
        let yourdate:NSDate = dateFor.dateFromString(str)!
        var cal = NSCalendar.currentCalendar()
        var com = cal.components([.Hour,.Minute], fromDate: yourdate)
        var ampm = ""
        var minute = ""
      
        if(com.hour >= 12)
        {
            ampm = "PM"
        }
        else
        {
            ampm = "AM"
        }
        if(com.minute == 0){
            cc.timelabel.text = "\(com.hour):\(com.minute)0 \(ampm)"
            }
        else
        {
            cc.timelabel.text = "\(com.hour):\(com.minute) \(ampm)"
            }
       
            
        default: break
        }
        return cc
        }
        else
        {
            let cc = collectionview2.dequeueReusableCellWithReuseIdentifier("cellid2", forIndexPath: indexPath) as! datecell
            let s1 = String(daate[indexPath.item][0])
            let s2 = String(daate[indexPath.item][1])
            let s3 = String(daate[indexPath.item][2])
            cc.label.text = "\(s1)-\(s2)-\(s3)"
            return cc
        }
    }
    func callapi2(gameid:String,insertspot:Int){
        print(gameid)
        print(insertspot)
    let ss = "https://api.sportradar.us/nba-t3/zh/games/"+gameid+"/boxscore.json?api_key=pa633fxvmezdkx24c5xwxqjp"
    
    let url = NSURL(string: ss)
    let request = NSMutableURLRequest(URL: url!)
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
    if error != nil {
    print(error)
        self.callapi2(gameid,insertspot:insertspot)
    return
    }
    do{
    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
    let jj = json["away"] as! NSDictionary
    let j1 = jj["points"] as! Int
   // print(j1)
   

        
    let jj2 = json["home"] as! NSDictionary
    let j2 = jj2["points"] as! Int
    
        self.awaypoint.insert(String(j1), atIndex: insertspot)
        self.homepoint.insert(String(j2), atIndex: insertspot)
    //print(j2)
    //self.pint = [String(j1),String(j2)]
    //self.collectionview.reloadData()
        dispatch_async(dispatch_get_main_queue(),{
            
            self.collectionview.reloadData()
        })
    
    }
    catch let error as NSError {
    print(error)
    self.callapi2(gameid,insertspot:insertspot)
        return
    }
    }.resume()
     
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if(collectionView == self.collectionview)
        {
        return CGSize(width: view.frame.width-30, height: 100)
        }
        else
        {
            return CGSize(width: 100, height: 50)
        }
    }

}

