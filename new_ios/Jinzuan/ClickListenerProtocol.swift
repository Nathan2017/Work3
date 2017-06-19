

import Foundation
protocol ClickListenerProtocol {
    /**觸發點擊事件 - 無傳遞參數*/
    func DoClicks()
    /**觸發點擊事件 - 有傳遞參數*/
    func DoClicks(clickListenerCondition:ClickListenerCondition)
    
}

