//
//  TestViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class MainViewController: ViewController, Refreshable, RefreshControllable {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Main"
        
        let button = UIButton()
        button.setTitle("click", for: .normal)
        button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        button.backgroundColor = .red
        view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerY.equalToSuperview()
            make.top.equalTo(100)
        }
    }
    
    @objc func clickAction() {
        let hud = BEEHUD.showLoading(message: "加载中..", view: view)

        Time.delay(5) {
            BEEHUD.showToast(message: "aaa", view: self.view)
        }

        Time.delay(7) {
            BEEHUD.showSuccess(message: "bbb", view: self.view)
        }

        Time.delay(9) {
            BEEHUD.showInfo(message: "ccc", view: self.view)
        }

        Time.delay(12) {
            BEEHUD.showError(message: "ddd", view: self.view)
        }
        
        //        let hud = BEEHUD.showProgress(progress: 0, message: "加载中..", view: view)
        //        Time.delay(1) {
        //            hud.mode = .determinate
        //            hud.progress = 0.1
        //        }
        //
        //        Time.delay(3) {
        //            hud.mode = .determinate
        //            hud.progress = 0.3
        //        }
        //
        //        Time.delay(5) {
        //            hud.progress = 0.5
        //        }
        //
        //        Time.delay(7) {
        //            hud.progress = 0.7
        //        }
        //
        //        Time.delay(9) {
        //            hud.progress = 0.9
        //        }
        //
        //        Time.delay(11) {
        //            BEEHUD.showSuccess(message: "上传成功", view: self.view)
        //        }
    }
    
}

