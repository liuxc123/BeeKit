//
//  ViewController.swift
//  BeeKit
//
//  Created by liuxc123 on 12/31/2020.
//  Copyright (c) 2020 liuxc123. All rights reserved.
//

import UIKit
import BeeKit

class ViewController: UITableViewController, RefreshControllable, Refreshable {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Main"
        view.backgroundColor = .white

        self.bee.setupRefresh(self, tableView)
        tableView.bee.headerNormal {
            log.info("headerNormal")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.bee.refreshStatus([.tEndRefresh(false)])
            }
        }
        .footerAuto {
            log.info("footerAuto")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.bee.refreshStatus([.tEndRefresh(true)])
            }
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigator.push("app://test")
    }
}

extension ViewController: StatefulViewable {
    
    func hasContent() -> Bool {
        return false
    }
}
