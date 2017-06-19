
import UIKit
/** 系統消息*/
class OfficialAnnouncementController:ViewController,ClickListenerProtocol{
    /** Layout*/
    var officialAnnouncementLayout:OfficialAnnouncementLayout!
    /** 系統消息DataSource*/
    var officialAnnouncementTableDataSource:OfficialAnnouncementTableDataSource!
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
        officialAnnouncementLayout = OfficialAnnouncementLayout(frame: self.view.frame,navigationBarFrame: self.navigationController?.navigationBar.frame,uiNavigationItem: self.navigationItem)
        officialAnnouncementLayout.loadView()
        view.addSubview(officialAnnouncementLayout)
        
        addButtonAction()
        //初始化重新刷新及載入更多VIEW
        initRefleshAndLoadMoreView()
        /**初始化DataSource*/
        initTableViewDataSource()
        loadData(true)
       // self.officialAnnouncementLayout?.back_btn!.addTarget(self,action:"backView", forControlEvents: .TouchUpInside)
    }
    
    func backView()
    {
        
        //self.navigationController?.popViewControllerAnimated(true)
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
        officialAnnouncementTableDataSource =  OfficialAnnouncementTableDataSource(datas: self.officialAnnouncementObjects,tableView: officialAnnouncementLayout.tableView,clickListenerProtocol: self)
        
        officialAnnouncementLayout.tableView.dataSource = officialAnnouncementTableDataSource
        officialAnnouncementLayout.tableView.delegate = officialAnnouncementTableDataSource
    }
    
    func loadData(isReflesh:Bool)
    {
        self.officialAnnouncementObjects = []
        let officialAnnouncementObject1 = OfficialAnnouncementObject()
        officialAnnouncementObject1.SYS_OfficialAnnouncement_ID = "1"
        officialAnnouncementObject1.Title = "關於金博乐"
        officialAnnouncementObject1.Content = "金博乐提供NBA最即時的比數 也可以查看前四天的比數 也可以知道隔天比賽時間 我們的app也提供NBA排名 將來也會提供更多的NBA資訊 像是 個人得分數據 或者是 各隊的輸贏場次"
        officialAnnouncementObject1.CreateDate = "2017-03-30"
        
        let officialAnnouncementObject2 = OfficialAnnouncementObject()
        officialAnnouncementObject2.SYS_OfficialAnnouncement_ID = "2"
        officialAnnouncementObject2.Title = "英国高尔夫球公开赛"
        officialAnnouncementObject2.Content = "是高尔夫球四大满贯赛事之一（另外三项是美国高尔夫公开赛、美国名人赛、美国职业高尔夫球协会锦标赛），于1860年开始举办，是四大满贯中历史最悠久的赛事。由英国的高尔夫球组织Royal and Ancient Golf Club of St Andrews（简称R&A）主办，于每年7月的第三个周末举行。2010年冠军得主是南非球手路易斯·欧修辛[2]，2011年冠军是北爱尔兰选手达伦·克拉克。2015年冠军是美国球手扎克·詹森。"
        officialAnnouncementObject2.CreateDate = "2017-03-11"
        
        let officialAnnouncementObject3 = OfficialAnnouncementObject()
        officialAnnouncementObject3.SYS_OfficialAnnouncement_ID = "3"
        officialAnnouncementObject3.Title = "大师锦标赛"
        officialAnnouncementObject3.Content = "与英国公开赛（The Open Championship）、美国公开赛（United States Open Championship）和PGA锦标赛（PGA Championship）同属高尔夫球界的四大锦标赛（Major Championship）赛事，每年都在奥古斯塔高尔夫球俱乐部举办，赛程长达四天。依照传统，胜利者会穿上代表名人赛冠军的绿色外套。而奥古斯塔球场为天才球员鲍比·琼斯所设计。"
        officialAnnouncementObject3.CreateDate = "2017-03-12"
         self.officialAnnouncementObjects = [officialAnnouncementObject1]
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
