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

    lazy var textView: LimitTextView = LimitTextView().then { (textView) in
        textView.theme.backgroundColor = UIColorTheme(.backgroundColor)
        textView.isEditable = false
        let attributedText = NSMutableAttributedString()
        attributedText.append("新开Test页面".localized.withLink(URL(string: "test".formatScheme())!).withFont(UIFontMake(16)))
        attributedText.append("\n返回首页".localized.withLink(URL(string: "beekit".formatScheme())!).withFont(UIFontMake(16)))
        attributedText.append("\n返回Foundation页面".localized.withLink(URL(string: "foundation".formatScheme())!).withFont(UIFontMake(16)))
        attributedText.append("\n返回UIKit页面".localized.withLink(URL(string: "uikit".formatScheme())!).withFont(UIFontMake(16)))

        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        textView.attributedText = attributedText.withParagraphStyle(style)
        textView.limitDelegate = self
    }

    var task: Schedule.Task?

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

        task = Plan.every(5.second).do(action: { (task) in
            print("do action")
        })

        task?.addAction({ (task) in
            print("action1")
        })

        task?.addAction({ (task) in
            print("action2")
        })
    }

}

extension TestViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        let alert = BEEAlertView(title: "跳转", message: "地址:\(URL.absoluteString)")
        alert.addAction(BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            if navigator.push(URL.absoluteString) != nil {
                return
            }
            navigator.open(URL.absoluteString)
        }))
        alert.show()
        return false
    }

    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let alert = BEEAlertView(title: "跳转", message: "地址:\(URL.absoluteString)")
        alert.addAction(BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            if navigator.push(URL.absoluteString) != nil {
                return
            }
            navigator.open(URL.absoluteString)
        }))
        alert.show()
        return false
    }

}
