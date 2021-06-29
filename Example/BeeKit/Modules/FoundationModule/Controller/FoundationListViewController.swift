//
//  FoundationListViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEETableKit

class FoundationListViewController: TableViewController {

    let dataSource: [(String, UIViewController.Type)] = [
        ("DispatchQueue", DispatchQueueViewController.self),
        ("Runloop", RunloopViewController.self)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Foundation"
        setupForm()
    }

    func setupForm() {

        let section = TableSection()

        for data in dataSource {
            let row = TableRow<DemoListTableViewCell>(value: data.0)
                .on(.click) { (options) in
                    navigator.push(data.1.init())
                }
            section.append(row: row)
        }
        tableDirector.append(section: section)
    }

}
