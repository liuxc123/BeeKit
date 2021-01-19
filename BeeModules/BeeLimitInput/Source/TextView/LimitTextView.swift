//
//  LimitTextView.swift
//  LimitInput
//
//  Created by liuxc on 2019/10/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit

@IBDesignable
open class LimitTextView: UITextView,LimitInputProtocol {

    public var preIR: IR? = nil

    /// 表情限制
    public var emojiLimit: Bool = LimitInput.emojiLimit
    /// 表情限制回调
    public var emojiLimitEvent: ((String) -> ())? = nil
    /// 字数限制
    public var wordLimit: Int = LimitInput.wordLimit
    /// 文字超出字符限制执行
    public var overWordLimitEvent: ((String) -> ())? = LimitInput.overWordLimitEvent
    // 完成输入
    public var textDidChangeEvent: ((_ text: String)->())? = nil
    /// 文字替换
    public var replaces: [LimitInputReplace] = LimitInput.replaces
    /// 判断输入是否合法的
    public var matchs: [LimitInputMatch] = LimitInput.matchs
    /// 菜单禁用项
    public var disables: [LimitInputDisableState] = LimitInput.disables

    /// 占位文本控件
    public lazy var placeholderLabel: UILabel = {
        let item = UILabel()
        item.numberOfLines = 0
        item.font = font
        item.textColor = UIColor.gray.withAlphaComponent(0.7)
        self.addSubview(item)
        self.setValue(item, forKeyPath: "_placeholderLabel")
        return item
    }()

    /// 占位颜色
    open var placeholderColor: UIColor{
        set{ placeholderLabel.textColor = newValue }
        get{ return placeholderLabel.textColor }
    }

    /// 占位富文本
    open var attributedPlaceholder: NSAttributedString? {
        set{ placeholderLabel.attributedText = newValue }
        get{ return placeholderLabel.attributedText }
    }

    /// 占位文本
    open var placeholder: String? {
        set{ placeholderLabel.text = newValue }
        get{ return placeholderLabel.text }
    }

    /// 字体设置
    open override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }

    private var inputHelp: LimitTextViewExecutor?

    /// 替换系统delegate
    open var limitDelegate: UITextViewDelegate? {
        get { return inputHelp }
        set {
            inputHelp = LimitTextViewExecutor(delegate: newValue)
            super.delegate = inputHelp
        }
    }

    /// 更新内间距
    open override var contentInset: UIEdgeInsets {
        didSet {
            scrollIndicatorInsets = .zero
            contentOffset = .zero
            textContainerInset = contentInset
            textContainer.lineFragmentPadding = 0
            setNeedsLayout()
        }
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        buildConfig()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        buildConfig()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.sizeThatFits(CGSize(width: self.width - contentInset.horizontal, height: .infinity))
        placeholderLabel.frame.origin = CGPoint(x: contentInset.left, y: contentInset.top)
    }

    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return canPerformAction(self, text: text, action: action) ? super.canPerformAction(action, withSender: sender) : false
    }

    //MARK: - Deinitialized
    deinit {
        self.delegate = nil
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - Config
extension LimitTextView{

    func buildConfig() {
        delegate = nil
        contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        font = UIFont.systemFont(ofSize: 16)
        buildNotifications()
    }

    fileprivate func buildNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textView(changed:)),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
}

extension LimitTextView {
    @objc private func textView(changed not: Notification) {
        guard let input = not.object as? LimitTextView, self === input else { return }
        guard let ir = textDidChange(input: input, text: input.text) else {
            input.textDidChangeEvent?(input.text ?? "")
            return
        }
        input.text = ir.text
        (input as UITextInput).selectedRange = ir.range
        input.textDidChangeEvent?(ir.text)
    }

}
