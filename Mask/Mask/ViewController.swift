//
//  ViewController.swift
//  Mask
//
//  Created by wu on 2017/12/27.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "蒙版展示"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addMaskView))
         LoadMaskView.showMaskView(onView: nil, delay: 0.45)
    }
}
private extension ViewController{
    @objc func addMaskView(){
        UserDefaults.standard.set(false, forKey: theFirst)
        UserDefaults.standard.synchronize()
        LoadMaskView.showMaskView(onView: nil, delay: 0.45)
    }
}

