//
//  TestViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit
import SnapKit

class MainViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Main"
        view.theme.backgroundColor = UIColorTheme(.backgroundColor)

        let textView = LimitTextView()
        textView.placeholder = "placeholder"
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(inset: 10))
        }
    }

}

