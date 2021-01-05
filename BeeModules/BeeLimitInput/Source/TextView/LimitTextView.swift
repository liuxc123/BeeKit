//
//  LimitTextView.swift
//  LimitInput
//
//  Created by liuxc on 2019/10/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
open class LimitTextView: UITextView,LimitInputProtocol {

    private let disposeBag = DisposeBag()

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
        item.font = UIFont.systemFont(ofSize: 15)
        item.textColor = UIColor.gray.withAlphaComponent(0.7)
        self.addSubview(item)
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

    private var inputHelp: LimitTextViewExecutor?

    /// 替换系统delegate
    override open var delegate: UITextViewDelegate? {
        get { return inputHelp }
        set {
            inputHelp = LimitTextViewExecutor(delegate: newValue)
            super.delegate = inputHelp
        }
    }

    /// 更新内间距
    open var inset: UIEdgeInsets = .zero {
        didSet {
            contentInset = .zero
            scrollIndicatorInsets = .zero
            contentOffset = .zero
            textContainerInset = inset
            textContainer.lineFragmentPadding = 0
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            placeholderLabel.removeConstraints(placeholderLabel.constraints)
            
            placeholderLabel.addConstraint(NSLayoutConstraint(item: placeholderLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: inset.top))
            
            placeholderLabel.addConstraint(NSLayoutConstraint(item: placeholderLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: inset.left))

            placeholderLabel.addConstraint(NSLayoutConstraint(item: placeholderLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -inset.right))
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
        inset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        buildNotifications()
        buildPlaceHolder()
    }

    fileprivate func buildNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textView(changed:)),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }

    fileprivate func buildPlaceHolder() {
        self.rx.text.map({ !($0?.isEmpty ?? true) } ).bind(to: placeholderLabel.rx.isHidden).disposed(by: disposeBag)
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
