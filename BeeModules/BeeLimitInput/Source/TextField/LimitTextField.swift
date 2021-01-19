//
//  LimitTextField.swift
//  LimitInput
//
//  Created by liuxc on 2019/10/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit

@IBDesignable
open class LimitTextField: UITextField, LimitInputProtocol {

    public var preIR: IR? = nil

    /// 表情限制
    public var emojiLimit: Bool = LimitInput.emojiLimit
    /// 表情限制回调
    public var emojiLimitEvent: ((String) -> ())? = nil
    /// 文字超出字符限制执行
    public var overWordLimitEvent: ((String) -> ())? = LimitInput.overWordLimitEvent
    /// 完成输入事件
    public var textDidChangeEvent: ((_ text: String)->())? = nil
    /// 字数限制
    public var wordLimit: Int = LimitInput.wordLimit
    /// 文字替换
    public var replaces: [LimitInputReplace] = LimitInput.replaces
    /// 判断输入是否合法的
    public var matchs: [LimitInputMatch] = LimitInput.matchs
    /// 菜单禁用项
    public var disables: [LimitInputDisableState] = LimitInput.disables

    private var inputHelp: LimitTextFieldExecutor?

    public var limitDelegate: UITextFieldDelegate? {
        get { return inputHelp }
        set { inputHelp = LimitTextFieldExecutor(delegate: newValue)
            super.delegate = inputHelp
        }
    }

    open override var isEditing: Bool {
        return super.isEditing
    }

    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return canPerformAction(self, text: text ?? "", action: action) ? super.canPerformAction(action, withSender: sender) : false
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        buildConfig()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        buildConfig()
    }

    /// MARK: - Deinitialized
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

/// MARK: - Config
extension LimitTextField{

    func buildConfig() {
        limitDelegate = nil
        buildNotifications()
    }

    fileprivate func buildNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textField(changed:)),
                                               name:  UITextField.textDidChangeNotification,
                                               object: nil)
    }

}

extension LimitTextField {

    @objc private func textField(changed not: Notification) {
        guard let input = not.object as? LimitTextField, self === input else { return }
        guard let ir = textDidChange(input: input, text: input.text ?? "") else {
            input.textDidChangeEvent?(input.text ?? "")
            return
        }
        input.text = ir.text
        (input as UITextInput).selectedRange = ir.range
        input.textDidChangeEvent?(ir.text)
    }
}
