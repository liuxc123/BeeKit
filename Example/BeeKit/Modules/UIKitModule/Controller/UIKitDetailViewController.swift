//
//  UIKitDetailViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit_Swift
import BEETableKit

class UIScreenViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "UIScreen"

        log.info("width: \(UIScreen.screenWidth)")
        log.info("height: \(UIScreen.screenHeight)")
        log.info("onePixle: \(UIScreen.onePixle)")
        log.info("safeAreaInsets: \(UIScreen.safeAreaInsets)")
        log.info("statusBar: \(UIScreen.statusBar)")
        log.info("navBar: \(UIScreen.navBar)")
        log.info("topBar: \(UIScreen.topBar)")
        log.info("tabBar: \(UIScreen.tabBar)")
        log.info("bottomBar: \(UIScreen.bottomBar)")
    }
}

class UIColorViewController: TableViewController {

    var dataSource: [UIColor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "UIColor"

        dataSource = []

        if #available(iOS 13.0, *) {
            dataSource = [
                .systemGray,
                .systemGray2,
                .systemGray3,
                .systemGray4,
                .systemGray5,
                .systemGray6,
                .label,
                .secondaryLabel,
                .tertiaryLabel,
                .quaternaryLabel,
                .link,
                .placeholderText,
                .separator,
                .opaqueSeparator,
                .systemBackground,
                .secondarySystemBackground,
                .tertiarySystemBackground,
                .systemGroupedBackground,
                .secondarySystemGroupedBackground,
                .tertiarySystemGroupedBackground,
                .systemFill,
                .secondarySystemFill,
                .tertiarySystemFill,
                .quaternarySystemFill,
                .lightText,
                .darkText
            ]

            for color in dataSource {
                log.info("\(color.doraemon_systemColorName()?.string ?? "")：\(color.hexString)")
            }
        }

        setupForm()
    }

    func setupForm() {

        let section = TableSection()

        for color in dataSource {
            let text = "\(color.doraemon_systemColorName()?.string ?? "")：\(color.hexString)"
            let row = TableRow<DemoListTableViewCell2>(value: (text, color))
                .on(.click) { (options) in
                    BEEHUD.showToast(message: text)
                }
            section.append(row: row)
        }
        tableDirector.append(section: section)
    }
}
