//
//  LimitInputProtocol.swift
//  AwesomeProject
//
//  Created by liuxc on 2019/10/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit
import Smile

extension UITextInput {

    var selectedRange: NSRange? {
        set {
            let beginning = beginningOfDocument
            guard let range = newValue,
                let start = position(from: beginning, offset: range.location),
                let end = position(from: beginning, offset: range.location + range.length)
                else { return }
            let selectionRange = textRange(from: start, to: end)
            self.selectedTextRange = selectionRange
        }
        get {
            guard let range = self.selectedTextRange else { return nil }
            let location = offset(from: beginningOfDocument, to: range.start)
            let length = offset(from: range.start, to: range.end)
            return NSRange(location: location, length: length)
        }
    }

}

public protocol LimitInputProtocol: NSObjectProtocol {
    // 判断输入是否合法的
    var matchs: [LimitInputMatch] { set get }
    // 文本替换 保证光标位置
    var replaces: [LimitInputReplace] { set get }
    // 字数限制
    var wordLimit: Int { set get }
    // 表情限制
    var emojiLimit: Bool { set get }
    // 菜单禁用项
    var disables: [LimitInputDisableState] { set get }
    // 超过字数限制
    var overWordLimitEvent: ((_ text: String)->())? { set get }
    // 表情限制事件
    var emojiLimitEvent: ((_ text: String)->())? { set get }
    // 完成输入
    var textDidChangeEvent: ((_ text: String)->())? { set get }
    var preIR: IR? { set get }
}

public struct IR {
    let text: String
    let range: NSRange
}

public extension LimitInputProtocol {

    func setOverWordLimitEvent(_ event: @escaping (_ text: String)->()) {
        self.overWordLimitEvent = event
    }

    func setTextDidChangeEvent(_ event: @escaping (_ text: String)->()) {
        self.textDidChangeEvent = event
    }
}

extension LimitInputProtocol {

    /// 获取输入后文本
    ///
    /// - Parameters:
    ///   - string: 原有字符串
    ///   - text: 插入字符
    ///   - range: 插入字符范围
    /// - Returns: 处理后文本与光标位置
    func getAfterInputText(string: String, text: String, range: NSRange) -> IR {
        var result = string
        var range = range
        // 删除操作
        switch text.isEmpty {
        case true:
            let startIndex = String.Index(utf16Offset: range.location, in: string)
            let endIndex = String.Index(utf16Offset: range.location + range.length, in: string)
            // 全选删除
            if startIndex <= result.startIndex {
                range.location = 0
                range.length = 0
                result = String(result[endIndex..<result.endIndex])
            }
            // 尾部删除
            else if endIndex >= result.endIndex {
                range.location -= text.utf16.count
                result = String(result[result.startIndex...startIndex])
            }
            // 局部删除
            else{
                range.length = 0
                result = String(result[result.startIndex...startIndex]) + String(result[endIndex..<result.endIndex])
            }
        case false:
            /// 正常输入
            let startIndex = String.Index(utf16Offset: range.location, in: string)
            let endIndex = String.Index(utf16Offset: range.location + range.length, in: string)
            // 头部添加
            if startIndex <= result.startIndex, range.length == 0 {
                range.location += text.utf16.count
                result = text + result
            }
            // 尾部添加
            else if endIndex >= result.endIndex, range.length == 0 {
                range.location += text.utf16.count
                result = result + text
            }
            // 局部替换
            else{
                range.length = text.utf16.count
                result = String(result[result.startIndex..<startIndex]) + text + String(result[endIndex..<result.endIndex])
            }
        }
        return IR(text: result, range: range)
    }


    /// 文本输入完成后处理
    ///
    /// - Parameters:
    ///   - input: 输入控件
    ///   - text: 文本
    func textDidChange(input: UITextInput, text: String) -> IR? {
        guard input.markedTextRange == nil, let range = input.selectedRange else { return nil }
        let ir = replaceWordLimit(text: text)
        let ir0 = replaceEmojiLimit(text: ir)
        let ir1 = replaces(ir: IR(text: ir0, range: range))
        let ir2 = match(text: ir1.text) ? ir1 : preIR
        return ir2
    }

    /// 文本输入前处理
    ///
    /// - Parameters:
    ///   - input: 输入控件
    ///   - range: 插入位置
    ///   - string: 待输入文本
    /// - Returns: 能否输入
    public func shouldChange(input: UITextInput, range: NSRange, string: String) -> Bool {

        guard let allRange = input.textRange(from: input.beginningOfDocument, to: input.endOfDocument),
            let text = input.text(in: allRange) else {
            return true
        }

        /// 表情限制
        if Smile.containsEmoji(string: string) && emojiLimit {
            emojiLimitEvent?(string)
            return false
        }

        self.preIR = IR(text: text, range: range)

        return true
    }

}

extension LimitInputProtocol {

    func replaces(ir: IR) -> IR {
        if self.replaces.isEmpty || ir.text.isEmpty { return ir }
        var text = ir.text
        var range = ir.range
        var offset = 0

        for item in replaces {
            let list = text.components(separatedBy: item.key)
            guard list.count > 1 else { continue }
            offset += list.count * abs(item.value.utf16.count - item.key.utf16.count)
            text = list.joined(separator: item.value)
        }

        range.location += offset
        return IR(text: text, range: range)
    }

    func replaceWordLimit(text: String) -> String {
        var text = text
        if text.count > wordLimit {
            return text.slice(from: 0, to: wordLimit)
        }
        return text
    }

    func replaceEmojiLimit(text: String) -> String {
        if !self.emojiLimit {
            return text
        }
        return text.filter({ !$0.isEmoji })
    }

}

public extension LimitInputProtocol {

    /// 判断输入是否合法的
    ///
    /// - Parameter text: 待判断文本
    /// - Returns: 结构
    func match(text: String) -> Bool {

        if text.isEmpty { return true }

        if text.count > wordLimit {
          overWordLimitEvent?(text)
          return false
        }

        for item in matchs {
            if !item.code(text) { return false }
        }
        return true
    }

}


public extension LimitInputProtocol {
    /// 是否响应工具条事件
    ///
    /// - Parameters:
    ///   - respoder: textView & textfield
    ///   - action: 执行方法名
    /// - Returns: 是否响应
    func canPerformAction(_ respoder: UIResponder,text: String, action: Selector) -> Bool {
        if disables == LimitInputDisableState.allCases { return false }

        guard let state = LimitInputDisableState(rawValue: action.description) else {
            return true
        }

        let res = !disables.contains(state)

        if state == .paste, let str = UIPasteboard.general.string {
            return !disables.contains(.paste) && (str.count + text.count) <= wordLimit
        }

        return res
    }
}




