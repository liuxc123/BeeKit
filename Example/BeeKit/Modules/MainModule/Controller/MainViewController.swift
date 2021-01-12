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

//        self.bee.setupRefresh(self, tableView)
//        self.tableView.bee
//            .headerNormal { [weak self] in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
//                    self?.bee.refreshStatus([.endRefresh(true)])
//                }
//            }
//            .footerAuto {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
//                    self?.bee.refreshStatus([.endRefresh(true)])
//                }
//            }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        navigator.push("http://www.baidu.com")
        navigator.push("test".formatScheme())
    }

}

