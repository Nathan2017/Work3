//
//  ViewController.swift
//  Standing
//
//  Created by Nathan on 3/29/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class StandController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var datacache:NSCache = {
        let ic = NSCache()
        return ic
    }()
    var count = 0
    let mx = ["東區","西區"]
    var easternconference:[team] = []
    var westernconference:[team] = []
    lazy var collectionview:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.registerClass(standingcell.self, forCellWithReuseIdentifier: "cellid")
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.whiteColor()
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        callapi()
        navigationItem.title = "NBA排名"
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        view.addSubview(collectionview)
        collectionview.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        collectionview.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        collectionview.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        collectionview.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 2
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         let mv = collectionview.dequeueReusableCellWithReuseIdentifier("cellid", forIndexPath: indexPath) as! standingcell
        //mv.backgroundColor = UIColor.redColor()
        mv.label.text = mx[indexPath.item]
        mv.activity.startAnimating()
       // print(self.easternconference)
       // for i in 0...14{
           // mv.pond[0].text = self.easternconference[0].name
        //}
        if indexPath.item == 0
        {
            if(self.easternconference.isEmpty != true)
            {
            for i in 0...14{
                mv.pond[i].text = self.easternconference[i].name
            }
                mv.activity.stopAnimating()
                mv.activity.hidesWhenStopped = true
            }
        }
        else
        {
            if(self.westernconference.isEmpty != true)
            {
            for i in 0...14{
                mv.pond[i].text = self.westernconference[i].name
            }
                mv.activity.stopAnimating()
                mv.activity.hidesWhenStopped = true
            }

        }
        return mv
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

            return CGSize(width: view.frame.width-30, height: 610)
        

    }
    func callapi(){
        let ss = "https://api.sportradar.us/nba-t3/zh/seasontd/2016/REG/rankings.json?api_key=pa633fxvmezdkx24c5xwxqjp"
        let url = NSURL(string: ss)
        let request = NSMutableURLRequest(URL: url!)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if error != nil {
                print(error)
                self.callapi()
                return
            }
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                
                    let jd = json["conferences"] as! NSArray
                    let jmd = jd[0] as! NSDictionary
                    
                    for mm in 0...2{
                        let jm = jmd["divisions"] as! NSArray
                        let fgh = jm[Int(mm)] as! NSDictionary
                        //print(jm)
                        // print(jm["teams"])
                        for md in 0...4 {
                            //  let mc = jm["teams"]![Int(md)] as! NSDictionary
                            let mc = fgh["teams"] as! NSArray
                            let mk = mc[Int(md)] as! NSDictionary
                            //       let conrank = mc["rank"]!["conference"] as! Int
                            let cc = mk["rank"] as! NSDictionary
                            let conrank = cc["conference"] as! Int
                            self.easternconference.append(team(name: String(mk["name"] as! String) , rank: conrank))
                            //print(conrank)
                        }
                    }
                    
                    //print(self.easternconference)
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        for i in 0...14{
                            
                            
                            self.easternconference.sortInPlace({ $0.rank < $1.rank })
                            self.collectionview.reloadData()
                            
                        }
                        
                    })
                    
                
                    let jd2 = json["conferences"] as! NSArray
                    print(jd2[1])
                    let jmd2 = jd2[1] as! NSDictionary
                    for mm in 0...2{
                        let jm = jmd2["divisions"] as! NSArray
                        let fgh = jm[Int(mm)] as! NSDictionary
                        //print(jm)
                        // print(jm["teams"])
                        for md in 0...4 {
                            //  let mc = jm["teams"]![Int(md)] as! NSDictionary
                            let mc = fgh["teams"] as! NSArray
                            let mk = mc[Int(md)] as! NSDictionary
                            //       let conrank = mc["rank"]!["conference"] as! Int
                            let cc = mk["rank"] as! NSDictionary
                            let conrank = cc["conference"] as! Int
                            self.westernconference.append(team(name: String(mk["name"] as! String) , rank: conrank))
                            //print(conrank)
                        }
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.westernconference.sortInPlace({ $0.rank < $1.rank })
                        self.collectionview.reloadData()
                    })
                
                    //self.count += 1
                
                
            }
            catch let error as NSError {
                print(error)
                self.callapi()
                return
            }
            }.resume()
    
    }

}

