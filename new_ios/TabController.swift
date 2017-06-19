//
//  TabController.swift
//  Nathan
//
//  Created by Nathan on 3/20/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
   /* if(MenuEnum.Test1 == menuEnum){
    return "高尔夫規則"
    }else if(MenuEnum.Test2 == menuEnum){
    return "系统讯息"
    }
    else if(MenuEnum.Test3 == menuEnum){
    return "增加自订规则"
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()

        let view1 = UINavigationController(rootViewController: GameController())
        view1.tabBarItem = UITabBarItem(title: "NBA比分", image: UIImage(named: "ic1.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        let view2 = UINavigationController(rootViewController: OfficialAnnouncementController())
        view2.tabBarItem = UITabBarItem(title: "系统讯息", image: UIImage(named: "i_company_announce.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        let view3 = UINavigationController(rootViewController: StandController())
        view3.tabBarItem = UITabBarItem(title: "NBA排名", image: UIImage(named: "ii.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 3)
        let view4 = UINavigationController(rootViewController: CalcsController())
        view4.tabBarItem = UITabBarItem(title: "计算机", image: UIImage(named: "calc.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 4)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let view5 = UINavigationController(rootViewController: CollectionViewController(collectionViewLayout: layout))
        view5.tabBarItem = UITabBarItem(title: "高尔夫图片介绍", image: UIImage(named: "pic.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 5)
        viewControllers = [view1,view3,view2]
    }


}
