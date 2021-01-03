//
//  ViewController.swift
//  BeeKit
//
//  Created by liuxc123 on 12/31/2020.
//  Copyright (c) 2020 liuxc123. All rights reserved.
//

import UIKit
import BeeKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Main"
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        navigator.present("http://www.baidu.com")
        navigator.push("app://test")
    }
}

extension ViewController: StatefulViewable {
    
    func hasContent() -> Bool {
        return false
    }
}
