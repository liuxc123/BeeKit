import Foundation
import UIKit

public protocol BeeViewProtocol {
    /// T: UIView、UIGestureRecognizer、NSLayoutConstraint、[NSLayoutConstraint]、、
    func addT<T>(_ t: T?)
    
    func appendView<T:UIView>(_ type:T.Type, _ handler:((T)->Void)?)
    
    
}
extension BeeViewProtocol {
    public func addT<T>(_ t: T?){
        guard let vv = self as? UIView else { return }
        switch t {
        case let subview as UIView where vv is UIStackView:
            (vv as? UIStackView)?.addArrangedSubview(subview)
        case let subview as UIView :
            vv.addSubview(subview)
        case let ges as UIGestureRecognizer :
            vv.addGestureRecognizer(ges)
        case let lay as NSLayoutConstraint :
            vv.addConstraint(lay)
        case let lays as [NSLayoutConstraint] :
            vv.addConstraints(lays)
        default:
            break
        }
        
    }
    
    public func appendView<T>(_ type: T.Type, _ handler: ((T) -> Void)? = nil) where T : UIView {
        switch self {
        case let stack as UIStackView:
            let v = T()
            handler?(v)
            stack.addArrangedSubview(v)
        case let vv as UIView:
            let v = T()
            handler?(v)
            vv.addSubview(v)
        default:
            break
        }
    }
    
}



public extension Bee where Base: UIView {
    @discardableResult
    func add<T>(_ t: T?) -> Bee {
        base.addT(t)
        return self
    }
    
    @discardableResult
    func append<T:UIView>(_ type:T.Type, _ handler:((T)->Void)?) -> Bee {
        base.appendView(type, handler)
        return self
    }
}


extension UIView: BeeViewProtocol {
    /*
    public func appendView<T>(_ type: T.Type, _ handler: ((T) -> Void)?) where T : UIView {
        self.cd.append(type, handler)
    }*/
    /*
    public func addT<T>(_ t: T?) {
        switch t {
        case let subview as UIView :
            self.addSubview(subview)
        case let ges as UIGestureRecognizer :
            self.addGestureRecognizer(ges)
        case let lay as NSLayoutConstraint :
            self.addConstraint(lay)
        case let lays as [NSLayoutConstraint] :
            self.addConstraints(lays)
        default:
            break
        }
    }*/
}


public extension Bee where Base: UIView {
    @discardableResult
    func frame(_ a: CGRect) -> Bee {
        base.frame = a
        return self
    }
    @discardableResult
    func frame(x: CGFloat = 0, y: CGFloat = 0, w: CGFloat = 0, h: CGFloat = 0) -> Bee {
        base.frame = CGRect(x: x, y: y, width: w, height: h)
        return self
    }
    @discardableResult
    func bounds(_ a: CGRect) -> Bee {
        base.bounds = a
        return self
    }
    @discardableResult
    func bounds(w: CGFloat = 0, h: CGFloat = 0) -> Bee {
        base.bounds = CGRect(x: 0, y: 0, width: w, height: h)
        return self
    }
    
    @discardableResult
    func center(_ a: CGPoint) -> Bee {
        base.center = a
        return self
    }
    
    @discardableResult
    func center(x: CGFloat = 0, y: CGFloat = 0) -> Bee {
        base.center = CGPoint(x: x, y: y)
        return self
    }
    @discardableResult
    func tag(_ a: Int) -> Bee {
        base.tag = a
        return self
    }
    @discardableResult
    func background(_ color: UIColor?) -> Bee {
        base.backgroundColor = color
        return self
    }
    
    @discardableResult
    func alpha(_ a: CGFloat) -> Bee {
        base.alpha = a
        return self
    }
    
    @discardableResult
    func content(_ mode: UIView.ContentMode) -> Bee {
        base.contentMode = mode
        return self
    }
    
    @discardableResult
    func isHidden(_ a: Bool) -> Bee {
        base.isHidden = a
        return self
    }
    
    @discardableResult
    func isOpaque(_ a: Bool) -> Bee {
        base.isOpaque = a
        return self
    }
    
    @discardableResult
    func isUser(_ interactionEnabled: Bool) -> Bee {
        base.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    func tint(_ color: UIColor) -> Bee {
        base.tintColor = color
        return self
    }
    
    @discardableResult
    func corner(_ radius: CGFloat) -> Bee {
        base.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func clips(_ toBounds: Bool) -> Bee {
        base.clipsToBounds = toBounds
        return self
    }
    
    @discardableResult
    func corner(_ radius:CGFloat, clips: Bool = true) -> Bee {
        base.layer.cornerRadius = radius
        base.clipsToBounds = clips
        return self
    }
    
    @discardableResult
    func masks(_ toBounds: Bool) -> Bee {
        base.layer.masksToBounds = toBounds
        return self
    }
    
    @discardableResult
    func border(_ width: CGFloat) -> Bee {
        base.layer.borderWidth = width
        return self
    }
    
    @discardableResult
    func border(_ color: UIColor) -> Bee {
        base.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func border(_ width:CGFloat, color: UIColor) -> Bee {
        base.layer.borderWidth = width
        base.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func shadow(_ path: CGPath) -> Bee {
        base.layer.shadowPath = path
        return self
    }
    
    @discardableResult
    func shadow(_ color: UIColor) -> Bee {
        base.layer.shadowColor = color.cgColor
        return self
    }
    
    @discardableResult
    func shadow(_ opacity: Float) -> Bee {
        base.layer.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    func shadow(_ offset: CGSize) -> Bee {
        base.layer.shadowOffset = offset
        return self
    }
    
    @discardableResult
    func shadow( w:CGFloat = 0, h:CGFloat = 0) -> Bee {
        base.layer.shadowOffset = CGSize(width: w, height: h)
        return self
    }
    
    @discardableResult
    func shadow(_ radius: CGFloat) -> Bee {
        base.layer.shadowRadius = radius
        return self
    }
    
    @discardableResult
    func shadow(_ path: CGPath?) -> Bee {
        base.layer.shadowPath = path
        return self
    }
    /// 阴影
    @discardableResult
    func shadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) -> Bee {
        base.layer.shadowColor = color.cgColor
        base.layer.shadowOffset = offset
        base.layer.shadowOpacity = opacity
        base.layer.shadowRadius = radius
        return self
    }
    /// 变形属性(平移\缩放\旋转)
    @discardableResult
    func transform(_ a: CGAffineTransform) -> Bee {
        base.transform = a
        return self
    }
    /// 自动调整子视图尺寸，默认YES则会根据autoresizingMask属性自动调整子视图尺寸
    @discardableResult
    func autoresizes(_ subviews: Bool) -> Bee {
        base.autoresizesSubviews = subviews
        return self
    }
    /// 自动调整子视图与父视图的位置，默认UIViewAutoresizingNone
    @discardableResult
    func autoresizing(_ mask: UIView.AutoresizingMask) -> Bee {
        base.autoresizingMask = mask
        return self
    }
    
    /// 圆角
    @discardableResult
    func rounded(_ corners:UIRectCorner, _ radii:CGSize) -> Bee {
        return self.rounded(base.bounds, corners, radii)
    }
    
    /// 圆角
    @discardableResult
    func rounded(_ rect:CGRect, _ corners:UIRectCorner, _ radii:CGSize) -> Bee {
        let rounded = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        base.layer.mask = shape
        return self
    }
    
    /// 背景线性渐变 默认横向渐变 point -> 0 - 1
    /// let gradients:[(UIColor,Float)] = [(UIColor.red,0),(UIColor.yellow,1)]
    /// view.cd.gradient(layer: gradients)
    /// 文字渐变 view.gradient(layerAxial: ..., then:{ layer in layer.mask = label.layer })
    @discardableResult
    func gradient(layerAxial gradients:[(color:UIColor,location:Float)], point:(start:CGPoint, end:CGPoint) = (start:CGPoint(x: 0, y: 0), end:CGPoint(x: 1, y: 0)), at: UInt32 = 0, updateIndex:Int? = nil, then:((CAGradientLayer)->Void)? = nil) -> Bee {
        
        func gradient(_ layer:CAGradientLayer) {
            base.layoutIfNeeded()
            layer.colors = gradients.map{$0.color.cgColor}
            layer.locations = gradients.map{NSNumber(value:$0.location)}
            layer.startPoint = point.start
            layer.endPoint = point.end
            layer.frame = base.bounds
        }
        
        let layers:[CAGradientLayer] = base.layer.sublayers?.filter{$0.isKind(of: CAGradientLayer.self)}.map{$0} as? [CAGradientLayer] ?? []
        if layers.count <= at {
            let layer = CAGradientLayer()
            gradient(layer)
            base.layer.insertSublayer(layer, at: at)
            then?(layer)
        }else{
            let layer = layers[updateIndex ?? 0]
            gradient(layers[updateIndex ?? 0])
            then?(layer)
        }
        return self
    }
    /// 放射性渐变
    class GradientLayer:CALayer {
        open var point: CGPoint = CGPoint.zero
        open var colorSpace = CGColorSpaceCreateDeviceRGB()
        open var locations:[CGFloat] = [0.0, 1.0]
        open var colors:[CGFloat] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0]
        open lazy var radius: CGFloat = {
            return Swift.max(self.bounds.size.width, self.bounds.size.height)
        }()
        override open func draw(in ctx: CGContext) {
            guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: locations, count: locations.count) else {
                return
            }
            ctx.drawRadialGradient(gradient, startCenter: point, startRadius: 0, endCenter: point, endRadius: radius, options: .drawsAfterEndLocation)
        }
    }
    /// 背景放射性渐变
    @discardableResult
    func gradient(layerRadial gradients:[(color:UIColor,location:CGFloat)], point:CGPoint = CGPoint(x: 0, y: 0), radius:CGFloat? = nil, at: UInt32 = 0, updateIndex:Int? = nil, then:((GradientLayer)->Void)? = nil) -> Bee {
        
        func gradient(_ layer:GradientLayer) {
            base.layoutIfNeeded()
            layer.locations = gradients.map{$0.location}
            layer.colors =  Array(gradients.map({ (c) -> [CGFloat] in
                let cc = c.color.bee_rgba
                return [cc.0,cc.1,cc.2,cc.3]
            }).joined())
            layer.frame = base.bounds
            layer.point = point
            layer.radius = radius ?? Swift.max(base.bounds.size.width, base.bounds.size.height)
            layer.setNeedsDisplay()
        }
        
        let layers:[GradientLayer] = base.layer.sublayers?.filter{$0.isKind(of: GradientLayer.self)}.map{$0} as? [GradientLayer] ?? []
        if layers.count <= at {
            let layer = GradientLayer()
            gradient(layer)
            base.layer.insertSublayer(layer, at: at)
            then?(layer)
        }else{
            let layer = layers[updateIndex ?? 0]
            gradient(layer)
            then?(layer)
        }
        return self
    }
    
    /// 毛玻璃效果 view.blurEffect(UIColor.red.withAlphaComponent(0.5))
    @discardableResult
    func blurEffect(_ color:UIColor = UIColor.clear,  style:UIBlurEffect.Style = .light, block:((UIVisualEffectView) -> Void)? = nil) -> Bee {
        base.layoutIfNeeded()
        base.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.backgroundColor = color
        blurEffectView.frame = base.bounds
        base.addSubview(blurEffectView)
        base.sendSubviewToBack(blurEffectView)
        block?(blurEffectView)
        return self
    }
    
    ///
    @discardableResult
    func then(_ block:(Base) -> Void) -> Bee {
        block(base)
        return self
    }
    
    
    
    @discardableResult
    func insert(_ subview:UIView, at index:Int = 0) -> Bee {
        base.insertSubview(subview, at: index)
        return self
    }
    
    @discardableResult
    func insert(_ subview:UIView, below view:UIView) -> Bee {
        base.insertSubview(subview, belowSubview: view)
        return self
    }
    @discardableResult
    func insert(_ subview:UIView, above view:UIView) -> Bee {
        base.insertSubview(subview, aboveSubview: view)
        return self
    }
    
    @discardableResult
    func exchange(_ subview1:Int, _ subview2:Int) -> Bee {
        base.exchangeSubview(at: subview1, withSubviewAt: subview2)
        return self
    }
    
    @discardableResult
    func bring(subviewToFront view:UIView) -> Bee {
        base.bringSubviewToFront(view)
        return self
    }
    
    @discardableResult
    func send(subviewToBack view:UIView) -> Bee {
        base.sendSubviewToBack(view)
        return self
    }
    
    @discardableResult
    func add(toSuperview view:UIView) -> Bee {
        view.addSubview(base)
        return self
    }
    
    @discardableResult
    func insert(toSuperview view:UIView, at index:Int) -> Bee {
        view.insertSubview(base, at: index)
        return self
    }
    
    @discardableResult
    func insert(toSuperview superview:UIView, below view:UIView) -> Bee {
        superview.insertSubview(base, belowSubview: view)
        return self
    }
    @discardableResult
    func insert(toSuperview superview:UIView, above view:UIView) -> Bee {
        superview.insertSubview(base, aboveSubview: view)
        return self
    }
    
    @discardableResult
    func exchange(_ view:UIView) -> Bee {
        guard let idx1 = base.superview?.subviews.firstIndex(of: base),
            let idx2 = base.superview?.subviews.firstIndex(of: view) else {
            return self
        }
        base.superview?.exchangeSubview(at: idx1, withSubviewAt: idx2)
        return self
    }
    
    @discardableResult
    func bringToFront() -> Bee {
        base.superview?.bringSubviewToFront(base)
        return self
    }
    
    @discardableResult
    func sendToBack() -> Bee {
        base.superview?.sendSubviewToBack(base)
        return self
    }
    
    @discardableResult
    func add(toSuperstack stack:UIStackView) -> Bee {
        stack.addArrangedSubview(base)
        return self
    }
    @discardableResult
    func insert(toSuperstack stack:UIStackView, at index:Int) -> Bee {
        stack.insertArrangedSubview(base, at: index)
        return self
    }
    
    @discardableResult
    func removeFromSuperview() -> Bee {
        base.removeFromSuperview()
        return self
    }
    
    @discardableResult
    func remove(subview view:UIView) -> Bee {
        base.subviews
            .filter{ $0 == view }
            .forEach{ $0.removeFromSuperview() }
        return self
    }
    
    @discardableResult
    func remove(subviews views:[UIView]) -> Bee {
        base.subviews
            .filter{ views.contains($0)}
            .forEach{ $0.removeFromSuperview() }
        return self
    }
}

//MARK:--- 返回非 self 将中断链式 ----------
public extension Bee where Base: UIView{
    func vc() -> UIViewController? {
        var next:UIResponder? = base
        repeat {
            next = next?.next
            if let vc = next as? UIViewController {
                return vc
            }
        }while next != nil
        return nil
    }
    
    /// 截图
    var cutImage:UIImage? {
        base.layoutIfNeeded()
        UIGraphicsBeginImageContextWithOptions(base.frame.size, true, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        base.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}


public extension Bee where Base: UIScrollView {
    /// 截长图
    var cutImageLong:UIImage? {
        base.layoutIfNeeded()
        let savedContentOffset = base.contentOffset
        let savedFrame = base.frame
        base.contentOffset = .zero
        base.frame = CGRect(x: 0, y: 0, width: base.contentSize.width, height: base.contentSize.height)
        guard let image = base.bee.cutImage else {
            base.contentOffset = savedContentOffset
            base.frame = savedFrame
            return nil
        }
        base.contentOffset = savedContentOffset
        base.frame = savedFrame
        return image
    }
}




