//
//  TestViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class MainViewController: UIViewController {
    
    let textView = LimitTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Main"
        view.backgroundColor = .yellow
    }
    
}

