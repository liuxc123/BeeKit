import Foundation
import UIKit

public extension Bee where Base: UIButton {
    @discardableResult
    ///addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event)
    func target(add target: Any?, action: Selector, event: UIControl.Event = .touchUpInside) -> Bee {
        base.addTarget(target, action: action, for: event)
        return self
    }
    
    func target(remove target: Any?, action: Selector, event: UIControl.Event = .touchUpInside) -> Bee {
        base.removeTarget(target, action: action, for: event)
        return self
    }
    
    @discardableResult
    func select(_ b: Bool) -> Bee {
        base.isSelected = b
        return self
    }
    
    @discardableResult
    func line(breakMode mode: NSLineBreakMode) -> Bee {
        base.titleLabel?.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, for state:UIControl.State = .normal) -> Bee {
        base.setImage(image, for: state)
        return self
    }
    @discardableResult
    func background(_ image: UIImage?, for state:UIControl.State = .normal) -> Bee {
        base.setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func attributed(_ title: NSAttributedString, for state:UIControl.State = .normal) -> Bee {
        base.setAttributedTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func title(_ edgeInsets: UIEdgeInsets) -> Bee {
        base.titleEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func title(edgeInsets top: CGFloat = 0, left:CGFloat = 0, bottom:CGFloat = 0, right:CGFloat = 0) -> Bee {
        base.titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func image(_ edgeInsets: UIEdgeInsets) -> Bee {
        base.imageEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func image(edgeInsets top: CGFloat = 0, left:CGFloat = 0, bottom:CGFloat = 0, right:CGFloat = 0) -> Bee {
        base.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func contentAlignment(horizontal: UIControl.ContentHorizontalAlignment) -> Bee {
        base.contentHorizontalAlignment = horizontal
        return self
    }
    @discardableResult
    func contentAlignment(vertical: UIControl.ContentVerticalAlignment) -> Bee {
        base.contentVerticalAlignment = vertical
        return self
    }
    @discardableResult
    func imageViewContent(_ mode: UIView.ContentMode) -> Bee {
        base.imageView?.contentMode = mode
        return self
    }
    @discardableResult
    func reverses(_ titleShadowWhenHighlighted: Bool) -> Bee {
        base.reversesTitleShadowWhenHighlighted = titleShadowWhenHighlighted
        return self
    }
    
    @discardableResult
    func adjusts(imageWhenHighlighted a: Bool) -> Bee {
        base.adjustsImageWhenHighlighted = a
        return self
    }
    
    @discardableResult
    func adjusts(imageWhenDisabled a: Bool) -> Bee {
        base.adjustsImageWhenDisabled = a
        return self
    }
    @discardableResult
    func shows(_ touchWhenHighlighted: Bool) -> Bee {
        base.showsTouchWhenHighlighted = touchWhenHighlighted
        return self
    }
    
    @discardableResult
    func loading(bgViewColor: UIColor = .clear,
                 bgViewFrame:CGRect = .zero,
                 style:UIActivityIndicatorView.Style = .gray,
                 activityColor:UIColor = .clear) -> Bee {
        base.isEnabled = false
        let activity = UIActivityIndicatorView(style: style)
        activity.startAnimating()
        let view = UIView()
        view.tag = -8668
        if bgViewFrame == .zero {
            base.superview?.layoutIfNeeded()
            view.frame = base.bounds
        }else{
            view.frame = bgViewFrame
        }
        if bgViewColor == .clear {
            view.backgroundColor = bgViewColor
        }else{
            view.backgroundColor = base.backgroundColor
        }
        if activityColor != .clear {
            activity.color = activityColor
        }
        activity.frame = view.bounds
        
        base.addSubview(view)
        view.addSubview(activity)
        return self
    }
    
    @discardableResult
    func loading(_ custom:(()->Void)) -> Bee {
        base.isEnabled = false
        custom()
        return self
    }
    
    @discardableResult
    func loadingHidden(_ tag:Int = -8668) -> Bee {
        base.viewWithTag(tag)?.removeFromSuperview()
        base.isEnabled = true
        return self
    }
}

