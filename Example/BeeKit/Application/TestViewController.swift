//
//  TestViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class TestViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.item.title = "test"
        self.bee.pop(disabled: true)

        navigation.bar.backBarButtonItem?.shouldBack = { [weak self] item in
            return self?.bee.popDisabled ?? false
        }
    }

}
