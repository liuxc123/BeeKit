import Foundation
import UIKit


public extension Bee where Base: UILabel {
    @discardableResult
    func number(_ ofLines: Int) -> Bee {
        base.numberOfLines = ofLines
        return self
    }
    @discardableResult
    func line(_ breakMode:NSLineBreakMode) -> Bee {
        base.lineBreakMode = breakMode
        return self
    }
    @discardableResult
    func baseline(_ adjustment:UIBaselineAdjustment) -> Bee {
        base.baselineAdjustment = adjustment
        return self
    }
    @discardableResult
    func allows(_ defaultTighteningForTruncation:Bool) -> Bee {
        base.allowsDefaultTighteningForTruncation = defaultTighteningForTruncation
        return self
    }
    @discardableResult
    func preferred(_ maxLayoutWidth:CGFloat) -> Bee {
        base.preferredMaxLayoutWidth = maxLayoutWidth
        return self
    }
    @discardableResult
    func adjusts(_ fontSizeToFitWidth:Bool) -> Bee {
        base.adjustsFontSizeToFitWidth = fontSizeToFitWidth
        return self
    }
    @discardableResult
    func highlighted(_ textColor:UIColor) -> Bee {
        base.highlightedTextColor = textColor
        return self
    }
    @discardableResult
    func minimum(_ scaleFactor:CGFloat) -> Bee {
        base.minimumScaleFactor = scaleFactor
        return self
    }
    
    /*
    @discardableResult
    func line(_ spacing:CGFloat) -> Bee {
        var textDic =
            [NSAttributedString.Key.foregroundColor:base.textColor,
             NSAttributedString.Key.font:base.font]
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        textDic[NSAttributedString.Key.paragraphStyle] = style
        if base.text!.count > 0 {
            base.attributedText = NSAttributedString(string: base.text!, attributes: textDic)
        }
        else if base.attributedText!.length > 0 {
            var attStr =  NSMutableAttributedString(attributedString: base.attributedText ?? NSAttributedString(string: base.text!))
            attStr.setAttributes(textDic, range: NSMakeRange(0, base.attributedText!.length))
        }
        return self
    }*/
    
    
}
