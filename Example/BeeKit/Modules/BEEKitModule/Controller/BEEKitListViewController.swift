//
//  BEEKitListViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEETableKit
import Schedule

class BEEKitListViewController: TableViewController {

    let dataSource: [(String, UIViewController.Type)] = [
        ("BEEApp", BEEAppViewController.self),
        ("BEELog", BEELogViewController.self),
        ("BEEBiometrics", BEEBiometricsViewController.self),
        ("BEETimer", BEETimerViewController.self),
        ("BEEDataStructures", BEEDataStructuresViewController.self),
        ("BEESystemSound", BEESystemSoundViewController.self),
        ("BEEPassword", BEEPasswordViewController.self),
        ("BEELinearView", BEELinearViewController.self),
        ("BEEHUD", BEEHUDViewController.self),
        ("BEEInput", BEEInputViewController.self),
        ("BEEIconFont", BEEIconFontViewController.self),
        ("BEETheme", BEEThemeViewController.self),
        ("BEELabel", BEELabelViewController.self),
        ("Refreshable and StatefulViewable", BEERefreshableViewController.self)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.theme.separatorColor = UIColorTheme(.separatorColor)
        setupForm()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.navigation.item.title = "BeeKit"

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
