//
//  LoadMaskView.swift
//  Mask
//
//  Created by wu on 2017/12/27.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

/// 以版本号作为关键字,效果你懂了,
let theFirst = "version_1.0"

class LoadMaskView{
    static func showMaskView(onView:UIView?,delay:TimeInterval = 0){
        /// 判断是否是第一次显示
        if !(UserDefaults.standard.value(forKey: theFirst) as? Bool ?? true){
            UserDefaults.standard.set(true, forKey: theFirst)
            UserDefaults.standard.synchronize()
            
            var showView = onView
            if onView == nil{
                guard let view = UIApplication.shared.keyWindow?.rootViewController?.view else{
                    return
                }
                showView = view
            }
            
            let maskView = MaskView(frame: UIScreen.main.bounds)
            
            maskView.add(rect: CGRect(x: showView!.frame.width - 180, y: 205, width: 170, height: 50), radius: 10)
            maskView.add(image: UIImage(named:"首页引导")!, frame: CGRect(x: showView!.frame.width - 220, y: 270, width: 210, height: 83))
            
            maskView.add(ovalRect: CGRect(x: 12, y: 22, width: 40, height: 40))
            
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + delay, execute: {
                DispatchQueue.main.async {
                    
                    maskView.showMaskView(view: showView!)
                }
            })
           
        }
    }
}
