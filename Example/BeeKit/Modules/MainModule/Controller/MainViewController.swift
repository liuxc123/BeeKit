//
//  TestViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class MainViewController: TableViewController, Refreshable, RefreshControllable {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Main"

        self.bee.setupRefresh(self, tableView)
        self.tableView.bee
            .headerNormal { [weak self] in
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                    self?.bee.refreshStatus([.endRefresh(false)])
                    navigator.push("test".formatScheme())
                }
            }
            .footerNormalBack {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                    self?.bee.refreshStatus([.endRefresh(false)])
                    navigator.push("http://www.baidu.com")
                }
            }
        
    }
}

