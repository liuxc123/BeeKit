import Foundation
import UIKit

public extension UIAlertController {
    @discardableResult
    static func bee_init(title: String? = nil, message: String? = nil, style : UIAlertController.Style = .alert) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: style)
    }
}

public extension Bee where Base: UIAlertController {
    
    @discardableResult
    func show(_ vc:UIViewController? = UIViewController.topMost, block:(()->Void)? = nil) -> Bee {
        if base.title == nil && base.message == nil && base.actions.count == 0 {
            assertionFailure("👻💀大哥！你别什么东西都不放💀👻")
            return self
        }
        vc?.present(base, animated: true, completion: block)
        return self
    }
    
    @discardableResult
    func hidden(_ time:TimeInterval, block:(()->Void)? = nil) -> Bee {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) { [weak base] in
            base?.dismiss(animated: true, completion: block)
        }
        return self
    }
    
    @discardableResult
    func title(_ a:String) -> Bee {
        base.title = a
        return self
    }
    @discardableResult
    func title(_ font:UIFont) -> Bee {
        let attributed:NSAttributedString = base.value(forKey: "attributedTitle") as? NSAttributedString ?? NSMutableAttributedString(string: base.title ?? "")
        let attributedM = NSMutableAttributedString(attributedString: attributed)
        attributedM.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedM.length))
        base.setValue(attributedM, forKey: "attributedTitle")
        return self
    }
    @discardableResult
    func title(_ color:UIColor) -> Bee {
        let attributed:NSAttributedString = base.value(forKey: "attributedTitle") as? NSAttributedString ?? NSMutableAttributedString(string: base.title ?? "")
        let attributedM = NSMutableAttributedString(attributedString: attributed)
        attributedM.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, attributedM.length))
        base.setValue(attributedM, forKey: "attributedTitle")
        return self
    }
    @discardableResult
    func title(_ attributed:NSAttributedString) -> Bee {
        base.setValue(attributed, forKey: "attributedTitle")
        return self
    }
    @discardableResult
    func message(_ a:String) -> Bee {
        base.message = a
        return self
    }
    @discardableResult
    func message(_ font:UIFont) -> Bee {
        let attributed:NSAttributedString = base.value(forKey: "attributedMessage") as? NSAttributedString ?? NSMutableAttributedString(string: base.message ?? "")
        let attributedM = NSMutableAttributedString(attributedString: attributed)
        attributedM.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedM.length))
        base.setValue(attributedM, forKey: "attributedMessage")
        return self
    }
    @discardableResult
    func message(_ color:UIColor) -> Bee {
        let attributed:NSAttributedString = base.value(forKey: "attributedMessage") as? NSAttributedString ?? NSMutableAttributedString(string: base.message ?? "")
        let attributedM = NSMutableAttributedString(attributedString: attributed)
        attributedM.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, attributedM.length))
        base.setValue(attributedM, forKey: "attributedMessage")
        return self
    }
    @discardableResult
    func message(_ attributed:NSAttributedString) -> Bee {
        base.setValue(attributed, forKey: "attributedMessage")
        return self
    }
    
    @discardableResult
    func action(_ title:String = "",
                style:UIAlertAction.Style = .default,
                custom:((UIAlertAction) -> Void)? = nil,
                handler:((UIAlertAction) -> Void)? = nil) -> Bee {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        custom?(action)
        base.addAction(action)
        return self
    }
}
public extension Bee where Base: UIAlertAction {
    @discardableResult
    func title(_ a:String) -> Bee {
        base.setValue(a, forKey: "title")
        return self
    }
    @discardableResult
    func title(_ color:UIColor) -> Bee {
        base.setValue(color, forKey: "titleTextColor")
        return self
    }
    @discardableResult
    func style(_ a:UIAlertAction.Style) -> Bee {
        base.setValue(a, forKey: "style")
        return self
    }
    @discardableResult
    func handler(_ a:((UIAlertAction) -> Void)? = nil) -> Bee {
        base.setValue(a, forKey: "handler")
        return self
    }
}

