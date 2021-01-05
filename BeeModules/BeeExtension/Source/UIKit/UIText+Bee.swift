/***** 模块文档 *****
 *
 */

import Foundation
import UIKit

//MARK:--- UITextField ----------
public extension Bee where Base: UITextField {
    @discardableResult
    func placeholder(_ p: String? = nil) -> Bee {
        base.placeholder = p
        return self
    }
    @discardableResult
    func placeholder(_ attributed: NSAttributedString? = nil) -> Bee {
        base.attributedPlaceholder = attributed
        return self
    }
    @discardableResult
    func border(_ style:UITextField.BorderStyle) -> Bee {
        base.borderStyle = style
        return self
    }
    @discardableResult
    func text(default attributes:[NSAttributedString.Key : Any]) -> Bee {
        base.defaultTextAttributes = attributes
        return self
    }
    @discardableResult
    func clear(onBeginEditing b:Bool) -> Bee {
        base.clearsOnBeginEditing = b
        return self
    }
    
    @discardableResult
    func clear(buttonMode b:UITextField.ViewMode) -> Bee {
        base.clearButtonMode = b
        return self
    }
    
    
    @discardableResult
    func adjusts(_ fontSizeToFitWidth:Bool) -> Bee {
        base.adjustsFontSizeToFitWidth = fontSizeToFitWidth
        return self
    }
    @discardableResult
    func minimumFont(_ size:CGFloat) -> Bee {
        base.minimumFontSize = size
        return self
    }
    @discardableResult
    func delegate(_ d:UITextFieldDelegate? = nil) -> Bee {
        base.delegate = d
        return self
    }
    @discardableResult
    func background(_ img:UIImage? = nil) -> Bee {
        base.background = img
        return self
    }
    @discardableResult
    func disabledBackground(_ img:UIImage? = nil) -> Bee {
        base.disabledBackground = img
        return self
    }
    @discardableResult
    func allows(editingTextAttributes b:Bool) -> Bee {
        base.allowsEditingTextAttributes = b
        return self
    }
    @discardableResult
    func typing(attributes b:[NSAttributedString.Key : Any]) -> Bee {
        base.typingAttributes = b
        return self
    }
    
    @discardableResult
    func left(view v:UIView) -> Bee {
        base.leftView = v
        return self
    }
    @discardableResult
    func left(viewMode v:UITextField.ViewMode) -> Bee {
        base.leftViewMode = v
        return self
    }
    @discardableResult
    func right(view v:UIView) -> Bee {
        base.rightView = v
        return self
    }
    @discardableResult
    func right(viewMode v:UITextField.ViewMode) -> Bee {
        base.rightViewMode = v
        return self
    }
    
    @discardableResult
    func returnKeyType(_ a:UIReturnKeyType) -> Bee {
        base.returnKeyType = a
        return self
    }
    
    @discardableResult
    func keyboardType(_ type:UIKeyboardType) -> Bee {
        base.keyboardType = type
        return self
    }
}


//MARK:--- UITextView ----------
public extension Bee where Base: UITextView {
    
    @discardableResult
    func delegate(_ d:UITextViewDelegate? = nil) -> Bee {
        base.delegate = d
        return self
    }
    
    @discardableResult
    func allows(editingTextAttributes b:Bool) -> Bee {
        base.allowsEditingTextAttributes = b
        return self
    }
    @discardableResult
    func typing(attributes b:[NSAttributedString.Key : Any]) -> Bee {
        base.typingAttributes = b
        return self
    }
    
    @discardableResult
    func isEditable(_ e: Bool) -> Bee {
        base.isEditable = e
        return self
    }
    
    @discardableResult
    func isSelectable(_ s: Bool) -> Bee {
        base.isSelectable = s
        return self
    }
    
    @discardableResult
    func text(containerInset c: UIEdgeInsets) -> Bee {
        base.textContainerInset = c
        return self
    }
    
    @discardableResult
    func data(detectorTypes d: UIDataDetectorTypes) -> Bee {
        base.dataDetectorTypes = d
        return self
    }
    
    @discardableResult
    func returnKeyType(_ a:UIReturnKeyType) -> Bee {
        base.returnKeyType = a
        return self
    }
    
    @discardableResult
    func keyboardType(_ type:UIKeyboardType) -> Bee {
        base.keyboardType = type
        return self
    }
    
}



//MARK:--- TextDelegate : TextField TextView 的代理 ----------
public class UITextDelegate: NSObject {
    
    
    var textFieldEditing:((UITextField, UIControl.Event)->Void)?
    var textFieldShouldClear:(( UITextField) -> Bool)?
    var textFieldShouldReturn:((UITextField) -> Bool)?
    var textFieldShouldChangeCharacters:((UITextField, NSRange, String) -> Bool)?
    
    var textViewEditing:((UITextView, UIControl.Event)->Void)?
    var textViewShouldClear:(( UITextView) -> Bool)?
    var textViewShouldReturn:((UITextView) -> Bool)?
    var textViewShouldChangeText:((UITextView, NSRange, String) -> Bool)?
    
    public init(textField editing:((UITextField, UIControl.Event)->Void)? = nil,
         shouldClear:(( UITextField) -> Bool)? = nil,
         shouldReturn:((UITextField) -> Bool)? = nil,
         shouldChangeCharacters:((UITextField, NSRange, String) -> Bool)? = nil) {
        textFieldEditing = editing
        textFieldShouldClear = shouldClear
        textFieldShouldReturn = shouldReturn
        textFieldShouldChangeCharacters = shouldChangeCharacters
    }
    
    public init(textView editing:((UITextView, UIControl.Event)->Void)? = nil,
         shouldClear:(( UITextView) -> Bool)? = nil,
         shouldReturn:((UITextView) -> Bool)? = nil,
         shouldChangeText:((UITextView, NSRange, String) -> Bool)? = nil) {
        textViewEditing = editing
        textViewShouldClear = shouldClear
        textViewShouldReturn = shouldReturn
        textViewShouldChangeText = shouldChangeText
    }
}
extension UITextDelegate: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textFieldShouldChangeCharacters?(textField,range,string) ?? true
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldEditing?(textField, .editingDidEnd)
    }
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldEditing?(textField, .editingDidBegin)
    }
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return textFieldShouldClear?(textField) ?? true
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textFieldShouldReturn?(textField) ?? true
    }
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
}
extension UITextDelegate: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        textViewEditing?(textView, .editingChanged)
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        textViewEditing?(textView, .editingDidEnd)
    }
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textViewEditing?(textView, .editingDidBegin)
    }
    public func textViewDidChangeSelection(_ textView: UITextView) {
        
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textViewShouldChangeText?(textView, range, text) ?? true
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return true
    }
    
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
}

public protocol UITextProtocol:NSObjectProtocol {
    var txt:String {set get}
}
extension UITextField: UITextProtocol {
    public var txt: String {
        get {
            return self.text ?? ""
        }
        set {
            self.text = newValue
        }
    }
}
extension UITextView: UITextProtocol {
    public var txt: String {
        get {
            return self.text
        }
        set {
            self.text = newValue
        }
    }
}

extension UITextDelegate {
    public enum Limit {
        /// 价格 decimal:小数点后位数限制 minus: 是否支持负数
        case tPrice(_ decimal:UInt, _ minus:Bool?)
        /// 数值 zero：是否支持0开头，minus: 是否支持负数
        case tInt(_ zero:Bool, _ minus:Bool?)
        /// 字母数字组合 lower: true(小写), false(大写)  nil(大小写混合)
        /// int:是否加入数字组合
        case tLetter(_ int:Bool, _ lower:Bool?)
        /// 定义正则匹配限制
        case tRegEx(_ pattern:String)
        ///
        case none
        
        func limitOutput(_ max:Int?, _ textInput:UITextProtocol, _ range: NSRange,  _ string: String, _ newText:String) -> Bool {
            switch self {
            case .tPrice(let decimal, let minus):
                let minus:Bool = minus ?? false
                var ints = (0..<10).map{$0.stringValue} + [".", ""]
                var pattern = "^[1-9]\\d*\\.?\\d{0,\(decimal)}$"
                if let max = max {
                    if newText.contains(".") {
                        pattern = "^[1-9]\\d{0,\(max-1)}\\.?\\d{0,\(decimal)}$"
                    }else{
                        pattern = "^[1-9]\\d{0,\(max-1)}$"
                    }
                }
                if minus {
                    ints += ["-"]
                    pattern[1..<1] = "-?"
                }
                guard ints.contains(string) else { return false }
                if textInput.txt.isEmpty && string != "." {
                    return true
                }
                return RegEx.match(newText, pattern: pattern)
            case .tInt(let zero, let minus):
                let minus:Bool = minus ?? false
                var ints = (0..<10).map{$0.stringValue} + [""]
                var pattern = zero ? "^\\d*$" : "^[1-9]\\d*$"
                if let max = max {
                    pattern = zero ? "^\\d{0,\(max)}$" : "^[1-9]\\d{0,\(max-1)}$"
                }
                if minus {
                    ints += ["-"]
                    pattern[1..<1] = "-?"
                }
                guard ints.contains(string) else { return false }
                return RegEx.match(newText, pattern: pattern)
            case .tLetter(let int, let lower):
                var pattern = lower==nil ? "^[a-zA-Z]*$" : (lower! ? "^[a-z]*$" : "^[A-Z]*$")
                if let max = max {
                    let count = pattern.count
                    pattern[count-2..<count-1] = "{0,\(max)}"
                }
                if int {
                    pattern[2..<2] = "\\d"
                }
                return RegEx.match(newText, pattern: pattern)
            case .tRegEx(let pattern):
                let bool = RegEx.match(newText, pattern: pattern)
                guard bool else { return bool }
                guard let max = max else { return bool }
                guard newText.count <= max else { return false }
                return true
            case .none:
                guard let max = max else { return true }
                guard newText.count <= max else { return false }
                return true
            }
        }
        
        public func limit(_ max:Int?, textInput:UITextProtocol, range: NSRange,  string: String, custom:((_ max:Int?, _ textInput:UITextProtocol, _ range: NSRange,  _ string: String, _ newText:String)->Bool)? = nil) -> Bool {
            guard !string.isEmpty else { return true }
            guard let r = Range.init(range, in: textInput.txt) else { return true }
            let new = textInput.txt.replacingCharacters(in: r, with: string)
            var bool = custom?(max, textInput, range, string, new) ?? true
            bool = limitOutput(max, textInput, range, string, new)
            return bool
        }
    }
}





