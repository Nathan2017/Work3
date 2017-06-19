//
//  ExplainController.swift
//  Nathan
//
//  Created by Nathan on 3/23/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

class ExplainController: UIViewController {
    let info:UITextView = {
       let info = UITextView()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.text = "使用增加自己的规则功能时可以按右上方的\"+\"就能进到添加规则或是游戏纪录 然后按下 \"完成编辑\" 即可 。当要修改规则 按你要修改的规则 就可以到修改页 修改完成后 按 \"完成编辑\" 即可 如果要移除规则 向左滑动 会出现 \"Delete\" 按下后便可移除 \n \n When using \"使用增加自己的规则功能\" you can press the \"+\" to add in your custom rule or game record. When you are done adding in the rule you can press \"完成编辑\" to end the editing. You can also edit your already made rule by tapping on the rule of your choice, which will bring you to the editing page, and when you are done editing press \"完成编辑\" to finish editing. You can always delete any rule you made, by swiping to the left for the rule of your choice, and press the \"Delete\" button."
        info.font = UIFont.systemFontOfSize(15)
        return info
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(info)
        navigationItem.title = "增加自订规则说明"
        info.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor,constant: 10).active = true
        info.leftAnchor.constraintEqualToAnchor(view.leftAnchor,constant: 10).active = true
        info.rightAnchor.constraintEqualToAnchor(view.rightAnchor,constant: -10).active = true
        info.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor,constant: -10).active = true
    }

}
