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

    }

}

extension ViewController: StatefulViewable {
    
    func hasContent() -> Bool {
        return false
    }
}

