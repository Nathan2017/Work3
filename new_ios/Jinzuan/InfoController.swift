//
//  InfoController.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/13.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit
/** 系統消息*/
class InfoController:ViewController,ClickListenerProtocol{
    /** Layout*/
    var officialAnnouncementLayout:InfoLayout!
    /** 系統消息DataSource*/
    var officialAnnouncementTableDataSource:InfoTableDataSource!
    /** 系統消息資料*/
    var officialAnnouncementObjects:[OfficialAnnouncementObject] = []
    /** 刷新Title*/
    let refreshTitle:String = "Slide down to Update"
    /** 載入中Title*/
    let loadingTitle:String = "Loading..."
    /** 刷新Control*/
    var refreshControl:UIRefreshControl!
    /** 現在是否載入中*/
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        //宣告Layout
        officialAnnouncementLayout = InfoLayout(frame: self.view.frame,navigationBarFrame: self.navigationController?.navigationBar.frame,uiNavigationItem: self.navigationItem)
        officialAnnouncementLayout.loadView()
        view.addSubview(officialAnnouncementLayout)
        
        addButtonAction()
        //初始化重新刷新及載入更多VIEW
        initRefleshAndLoadMoreView()
        /**初始化DataSource*/
        initTableViewDataSource()
        loadData(true)
      //  self.officialAnnouncementLayout?.back_btn!.addTarget(self,action:"backView", forControlEvents: .TouchUpInside)
    }
    
    func backView()
    {
        
       // self.navigationController?.popViewControllerAnimated(true)
        var gg = ViewController()
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.window!.rootViewController = gg
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if self.refreshControl?.refreshing == false && isLoading == true {
            self.refreshControl?.beginRefreshing()
            self.refreshControl?.attributedTitle = NSAttributedString(string: loadingTitle)
            officialAnnouncementLayout.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
        }
    }
    
    /** 初始化重新刷新及載入更多VIEW*/
    func initRefleshAndLoadMoreView(){
        //重新刷新
        refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: refreshTitle)
        self.refreshControl?.tintColor = UIColor.grayColor()
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        officialAnnouncementLayout.tableView.addSubview(refreshControl)
    }
    
    /** 增加新增及返回鍵監聽事件*/
    func addButtonAction()
    {
        officialAnnouncementLayout.push_btn.addTarget(self, action: "tappedButton:", forControlEvents: .TouchUpInside)
        
    }
    
    /**  監聽Button事件*/
    func tappedButton(sender: UIButton!) {
        if(sender != nil)
        {
            if(sender.tag == officialAnnouncementLayout.Button_Push)
            {
                dispatch_async(dispatch_get_main_queue()) {
                    self.navigationController?.popViewControllerAnimated(true)
                }
                return
            }
        }
    }
    
    
    func refresh() {
        if self.refreshControl?.refreshing == true {
            self.refreshControl?.attributedTitle = NSAttributedString(string: loadingTitle)
        }
        loadData(true)
    }
    
    func refreshEnd(){
        self.refreshControl?.endRefreshing()
        self.refreshControl?.attributedTitle = NSAttributedString(string: self.refreshTitle)
    }
    
    
    /**初始化DataSource*/
    func initTableViewDataSource(){
        //建置固定欄位資料
        officialAnnouncementTableDataSource =  InfoTableDataSource(datas: self.officialAnnouncementObjects,tableView: officialAnnouncementLayout.tableView,clickListenerProtocol: self)
        
        officialAnnouncementLayout.tableView.dataSource = officialAnnouncementTableDataSource
        officialAnnouncementLayout.tableView.delegate = officialAnnouncementTableDataSource
        
        officialAnnouncementLayout.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func loadData(isReflesh:Bool)
    {
        self.officialAnnouncementObjects = []
        let officialAnnouncementObject1 = OfficialAnnouncementObject()
        officialAnnouncementObject1.SYS_OfficialAnnouncement_ID = "1"
        officialAnnouncementObject1.Title = "高尔夫"
        officialAnnouncementObject1.Content = "高尔夫球，歌尔夫球，高而富球，俗称小白球，是一种室外体育运动。个人或团体球员以高尔夫球杆将一颗小球打进果岭的洞内。使用杆数较少者获胜。大部分的比赛有9洞或18洞"
        officialAnnouncementObject1.CreateDate = " "
        officialAnnouncementObject1.IsShow = true
        
        
        
        let officialAnnouncementObject2 = OfficialAnnouncementObject()
        officialAnnouncementObject2.SYS_OfficialAnnouncement_ID = "2"
        officialAnnouncementObject2.Title = "高尔夫球场"
        officialAnnouncementObject2.Content = "高尔夫球场是由许多的球洞组成，每一个球洞都有发球台，发球台前会有二个标志说明发球台的范围，此外还有球道、长草、其他障碍、在球洞附近的果岭、球洞及标示球洞位置的旗子。高尔夫球场长草的程度会影响比赛的难度，在果岭附近的草会特别养护，以便球可以在草地上滚动。有些球洞可以从发球台直接看到球洞，但有些则会设计为左弯或是右弯，类似狗的腿，因此称为“狗腿洞”，有些球洞甚至在中间会有二次的弯曲，称为“双狗腿洞”。"
        officialAnnouncementObject2.CreateDate = " "
        officialAnnouncementObject2.IsShow = true
        
        let officialAnnouncementObject3 = OfficialAnnouncementObject()
        officialAnnouncementObject3.SYS_OfficialAnnouncement_ID = "3"
        officialAnnouncementObject3.Title = "果岭"
        officialAnnouncementObject3.Content = "果岭是green的音译。果岭的品质并不是相同的。一般来说，最好的果岭都是得到很好养护，使得球可以很平滑的贴著切割过的草坪上滚动。高尔夫爱好者一般把好的果岭描述为faster（快的），轻轻的一击球就可以在上面滚动很远。相对的，如果球在上面滚动相当的距离需要很大的力气去击球，这样的果岭称为slow（慢的）（视果岭的草种以及长短，生长方向而决定果岭的快慢）由于果岭的地形高低起伏会让打者感觉其困难度。"
        officialAnnouncementObject3.CreateDate = " "
        officialAnnouncementObject3.IsShow = true
        
        let officialAnnouncementObject4 = OfficialAnnouncementObject()
        officialAnnouncementObject4.SYS_OfficialAnnouncement_ID = "4"
        officialAnnouncementObject4.Title = "标准杆"
        officialAnnouncementObject4.Content = "球洞会依标准杆来分类，标准杆是指球员根据设计应当完成的杆数。杆数中一定会包括发球的一杆及二个推杆，因此标准杆至少是三杆，但标准杆是四杆或五杆的球洞也很常见，甚至也有标准杆是六杆或七杆的球洞。发球以外的击球以及推杆一般会在球道进行。例如一个有经验的球员在标准杆四杆的球洞时，会希望在第一次击球发球后，第二次击球就可以将球击到果岭，再用二个推杆使球进洞，就可以平标准杆。若是击球让球上果岭后，还留有二次推杆机会可以使球进洞，则称为标准杆上果岭，简称GIR"
        officialAnnouncementObject4.CreateDate = " "
        officialAnnouncementObject4.IsShow = true
        self.officialAnnouncementObjects = [officialAnnouncementObject1,officialAnnouncementObject2,officialAnnouncementObject3,officialAnnouncementObject4]
        updateData()
    }
    
    func updateData()
    {
        dispatch_async(dispatch_get_main_queue()) {
            self.officialAnnouncementTableDataSource.updateData(self.officialAnnouncementObjects)
            self.officialAnnouncementLayout.tableView.reloadData()
            self.refreshEnd()
        }
        
    }
    
    /**觸發點擊事件 - 無傳遞參數*/
    func DoClicks()
    {
        print("觸發返回事件")
    }
    /**觸發點擊事件 - 有傳遞參數*/
    func DoClicks(clickListenerCondition:ClickListenerCondition)
    {
        
        
        if(clickListenerCondition.object != nil)
        {
            let selObject = clickListenerCondition.object as! OfficialAnnouncementObject
            if(selObject.IsShow)
            {
                selObject.IsShow = false
            }else
            {
                selObject.IsShow = true
            }
            
            if(selObject.IsReaded == nil || selObject.IsReaded == "0")
            {
                selObject.IsReaded = "1"
            }
            
            
            var index = 0
            for obj in self.officialAnnouncementObjects
            {
                if(obj.SYS_OfficialAnnouncement_ID != nil)
                {
                    if(obj.SYS_OfficialAnnouncement_ID == selObject.SYS_OfficialAnnouncement_ID)
                    {
                        self.officialAnnouncementObjects[index] = selObject
                        break
                    }
                }
                index += 1
            }
            self.updateData()
        }
        print("觸發傳遞參數事件")
    }
}
