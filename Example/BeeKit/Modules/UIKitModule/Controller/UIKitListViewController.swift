//
//  UIKitListViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEETableKit

class UIKitListViewController: TableViewController {

    let dataSource: [(String, UIViewController.Type)] = [
        ("CAShapeLayer", CAShapeLayerViewController.self),
        ("CATextLayer", CATextLayerViewController.self),
        ("CAGradientLayer", CAGradientLayerViewController.self),
        ("CAReplicatorLayer", CAReplicatorLayerViewController.self),
        ("UIScreen", UIScreenViewController.self)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "UIKit"
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
