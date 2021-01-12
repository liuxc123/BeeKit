//
//  TestViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class MainViewController: TableViewController, Refreshable, RefreshControllable {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Main"

//        let linearView = LinearView()
//        view.addSubview(linearView)
//        linearView.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.width.equalTo(200)
//        }
//
//        let a = UIView()
//        a.snp.makeConstraints({ $0.height.equalTo(30) })
//        a.backgroundColor = .random
//
//        let b = UIView()
//        b.snp.makeConstraints({ $0.height.equalTo(40) })
//        b.backgroundColor = .random
//
//        let c = UIView()
//        c.snp.makeConstraints({ $0.height.equalTo(50) })
//        c.backgroundColor = .random
//
//        linearView.layout(.vertical)
//            .view(a)
//            .spacing(10)
//            .view(b)
//            .spacing(20, mode: .follow)
//            .view(c)
//            .done()
//
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            UIView.animate(withDuration: 0.3) {
//                c.isHidden = true
//            }
//        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigator.push("http://www.baidu.com")
    }

}

