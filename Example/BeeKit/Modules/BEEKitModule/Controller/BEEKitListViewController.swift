//
//  BEEKitListViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEETableKit

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
        ("Refreshable and StatefulViewable", BEERefreshableViewController.self)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BeeKit"
        setupForm()
    }

    fileprivate func extractedFunc(_ data: (String, UIViewController.Type)) -> TableRow<DemoListTableViewCell> {
        return TableRow<DemoListTableViewCell>(value: data.0)
    }
    
    func setupForm() {

        let section = TableSection()

        for data in dataSource {
            let row = extractedFunc(data)
                .on(.click) { (options) in
                    navigator.push(data.1.init())
                }
            section.append(row: row)
        }
        tableDirector.append(section: section)
    }
    
}
