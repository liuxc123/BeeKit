//
//  TestViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit_Swift
import SnapKit
import BEEPopupKit

class TestViewController: ViewController {

    let textView: LimitTextView = LimitTextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.item.title = "test"
        self.bee.pop(disabled: true)

        navigation.bar.backBarButtonItem?.shouldBack = { [weak self] item in
            return self?.bee.popDisabled ?? false
        }

        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(88)
            make.left.right.bottom.equalToSuperview()
        }

        textView.theme.backgroundColor = UIColorTheme(.backgroundColor)
        textView.isEditable = false
        textView.attributedText = "click".localized.withLink(URL(string: "app://test")!)
        textView.limitDelegate = self
    }

}

extension TestViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        let alert = BEEAlertView(title: "跳转", message: "地址:\(URL.absoluteString)")
        alert.addAction(BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            navigator.push(URL.absoluteString)
        }))
        alert.show()
        return false
    }

    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let alert = BEEAlertView(title: "跳转", message: "地址:\(URL.absoluteString)")
        alert.addAction(BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            navigator.push(URL.absoluteString)
        }))
        alert.show()
        return false
    }

}
