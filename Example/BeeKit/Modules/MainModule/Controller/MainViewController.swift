//
//  TestViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class MainViewController: ViewController, Refreshable, RefreshControllable {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Main"
        
        let button = UIButton()
        button.setTitle("click", for: .normal)
        button.setImageForAllStates(UIImage(named: "ic_tips_done")!)
        button.setImagePosition(position: .top, spacing: 10)
        button.addTarget(self, action: #selector(clickAction(_:)), for: .touchUpInside)
        button.backgroundColor = .red
        view.addSubview(button)

        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(100.auto())
            make.centerX.equalToSuperview()
            make.top.equalTo(100.auto())
        }
    }
    
    @objc func clickAction(_ sender: UIButton) {

    }
    
}

