/***** 模块文档 *****
 *
 */


import Foundation
import UIKit


public extension Bee where Base: UITabBarController {
    @discardableResult
    func add(_ vc:UIViewController) -> Bee {
        base.addChild(vc)
        return self
    }
    
    @discardableResult
    func viewControllers(_ vc:[UIViewController]) -> Bee {
        base.viewControllers = vc
        return self
    }
}


public extension Bee where Base: UITabBar {
    
    /// 去掉tabBar顶部线条
    @discardableResult
    func hideLine() -> Bee {
       
        let rect = CGRect(x: 0, y: 0, width: base.bounds.size.width, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.clear.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        base.backgroundImage = image
        base.shadowImage = image
        return self
    }
    
    /// 简单添加顶部阴影  background 默认使用 barTintColor，如果 barTintColor 为clear 的话，不会显示阴影，需要设置一个background
    @discardableResult
    func addShadowLine(_ color:UIColor = UIColor.bee_hex("d3", dark:"f0"), backgroundColor bgColor:UIColor? = nil, layout:((UIView)->Void)? = nil) -> Bee {
        self.hideLine()
        let view = UIView(frame: CGRect(x: 0, y: 0, w: base.frame.size.width, h: 0.5)).bee
            .background(bgColor ?? base.barTintColor)
            .shadow(color)
            .shadow(CGSize(w: 0, h: -2))
            .shadow(CGFloat(2.0))
            .shadow(Float(0.8))
            .clips(false)
            .build
        base.bee
            .add(view)
            .clips(false)
        layout?(view)
        return self
    }
    
    
    @discardableResult
    func isTranslucent(_ b:Bool) -> Bee {
        base.isTranslucent = b
        return self
    }
    
    @discardableResult
    func barTintColor(_ b:UIColor) -> Bee {
        base.barTintColor = b
        return self
    }
    
    
    @discardableResult
    func addTabBarItem(_ item:UITabBarItem) -> Bee {
        base.items?.append(item)
        return self
    }
    
    @discardableResult
    func tabBarItems(_ items:[UITabBarItem]) -> Bee {
        base.items = items
        return self
    }

    @discardableResult
    func imageInsets(_ t:[UIEdgeInsets]) -> Bee {
        base.bee_imageInsets = t
        return self
    }
    
    @discardableResult
    func imageNormals(_ t:[UIImage?]) -> Bee {
        base.bee_imageNormals = t
        return self
    }
    
    @discardableResult
    func imageSelects(_ t:[UIImage?]) -> Bee {
        base.bee_imageSelects = t
        return self
    }
    @discardableResult
    func titles(_ t:[String?]) -> Bee {
        base.bee_titles = t
        return self
    }
    @discardableResult
    func badges(_ t:[String?]) -> Bee {
        base.bee_badges = t
        return self
    }
    
    @discardableResult @available(iOS 10.0, *)
    func badgeColors(_ t:[UIColor?]) -> Bee {
        base.bee_badgeColors = t
        return self
    }
    
    @discardableResult
    func colorNormals(_ t:[UIColor?]) -> Bee {
        base.bee_colorNormals = t
        return self
    }
    @discardableResult
    func colorSelecteds(_ t:[UIColor?]) -> Bee {
        base.bee_colorSelecteds = t
        return self
    }
    
    
    @discardableResult
    func colorHighlighteds(_ t:[UIColor?]) -> Bee {
        base.bee_colorHighlighteds = t
        return self
    }
    @discardableResult
    func fontNormals(_ t:[UIFont?]) -> Bee {
        base.bee_fontNormals = t
        return self
    }
    @discardableResult
    func fontSelecteds(_ t:[UIFont?]) -> Bee {
        base.bee_fontSelecteds = t
        return self
    }
    
    @discardableResult
    func fontHighlighteds(_ t:[UIFont?]) -> Bee {
        base.bee_fontHighlighteds = t
        return self
    }
    @discardableResult @available(iOS 10.0, *)
    func badgeColorNormals(_ t:[UIColor?]) -> Bee {
        base.bee_badgeColorNormals = t
        return self
    }
    @discardableResult @available(iOS 10.0, *)
    func badgeColorSelecteds(_ t:[UIColor?]) -> Bee {
        base.bee_badgeColorSelecteds = t
        return self
    }
    @discardableResult @available(iOS 10.0, *)
    func badgeColorHighlighteds(_ t:[UIColor?]) -> Bee {
        base.bee_badgeColorHighlighteds = t
        return self
    }
    
    @discardableResult @available(iOS 10.0, *)
    func badgeFontNormals(_ t:[UIFont?]) -> Bee {
        base.bee_badgeFontNormals = t
        return self
    }
    
    
    @discardableResult @available(iOS 10.0, *)
    func badgeFontSelecteds(_ t:[UIFont?]) -> Bee {
        base.bee_badgeFontSelecteds = t
        return self
    }
    
    
    @discardableResult @available(iOS 10.0, *)
    func badgeFontHighlighteds(_ t:[UIFont?]) -> Bee {
        base.bee_badgeFontHighlighteds = t
        return self
    }
    
    @discardableResult
    func color(_ normals:[UIColor?] = [], selecteds:[UIColor?] = [], highlighteds:[UIColor?] = []) -> Bee {
        base.bee_colorNormals = normals
        base.bee_colorSelecteds = selecteds
        base.bee_colorHighlighteds = highlighteds
        if #available(iOS 10.0, *) {
            base.bee_badgeColorNormals = normals
            base.bee_badgeColorSelecteds = selecteds
            base.bee_badgeColorHighlighteds = highlighteds
        } else {
            
        }
        return self
    }
    
    @discardableResult
    func font(_ normals:[UIFont?] = [], selecteds:[UIFont?] = [], highlighteds:[UIFont?] = []) -> Bee {
        base.bee_fontNormals = normals
        base.bee_fontSelecteds = selecteds
        base.bee_fontHighlighteds = highlighteds
        if #available(iOS 10.0, *) {
            base.bee_badgeFontNormals = normals
            base.bee_badgeFontSelecteds = selecteds
            base.bee_badgeFontHighlighteds = highlighteds
        } else {
            
        }
        return self
    }
    
    //MARK:--- badge ----------
    @discardableResult
    func setTitle<T>(_ value:[T?], key:NSAttributedString.Key, for state: UIControl.State) -> Bee {
        guard let items = base.items else { return self}
        for (i, item) in items.enumerated() where i < value.count && value[i] != nil {
            if var attributes = item.titleTextAttributes(for: state) {
                attributes[key] = value[i]
                item.setTitleTextAttributes(attributes, for:state)
            }else{
                item.setTitleTextAttributes([key:value[i]!], for:state)
            }
        }
        return self
    }
    
    func getTitle<T>(_ key:NSAttributedString.Key, for state: UIControl.State) -> [T?] {
        let fonts = base.items?.map({ (item) -> T? in
            guard let attributes = item.titleTextAttributes(for: state) else { return nil }
            guard let font = attributes[key] as? T else{ return nil }
            return font
        })
        return fonts ?? []
    }
    
    
    @discardableResult @available(iOS 10.0, *)
    func setBadge<T>(_ value:[T?], key:NSAttributedString.Key, for state: UIControl.State) -> Bee {
        guard let items = base.items else { return self}
        for (i, item) in items.enumerated() where i < value.count && value[i] != nil {
            if var attributes = item.badgeTextAttributes(for: state) {
                attributes[key] = value[i]
                item.setBadgeTextAttributes(attributes, for:state)
            }else{
                item.setBadgeTextAttributes([key:value[i]!], for:state)
            }
        }
        return self
    }
    
    @available(iOS 10.0, *)
    func getBadge<T>(_ key:NSAttributedString.Key, for state: UIControl.State) -> [T?] {
        let fonts = base.items?.map({ (item) -> T? in
            guard let attributes = item.badgeTextAttributes(for: state) else { return nil }
            guard let font = attributes[key] as? T else{ return nil }
            return font
        })
        return fonts ?? []
    }
}

public extension UITabBar {
    var bee_imageNormals:[UIImage?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                if let img = newValue[i] {
                    item.image = img.withRenderingMode(.alwaysOriginal)
                }
            }
        }
        get{
            return self.items?.map{$0.image} ?? []
        }
    }
    
    var bee_imageSelects:[UIImage?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                if let img = newValue[i] {
                    item.selectedImage = img.withRenderingMode(.alwaysOriginal)
                }
            }
        }
        get{
            return self.items?.map{$0.selectedImage} ?? []
        }
    }
    
    /// 矫正TabBar图片位置
    var bee_imageInsets:[UIEdgeInsets] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                item.imageInsets = newValue[i]
            }
        }
        get{
            return self.items?.map{$0.imageInsets} ?? []
        }
    }
    
    var bee_titles:[String?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                item.title = newValue[i]
            }
        }
        get{
            return self.items?.map{$0.title} ?? []
        }
    }
    
    var bee_badges:[String?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                item.badgeValue = newValue[i]
            }
        }
        get{
            return self.items?.map{$0.badgeValue} ?? []
        }
    }
    
    @available(iOS 10.0, *)
    var bee_badgeColors:[UIColor?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                item.badgeColor = newValue[i]
            }
        }
        get{
            return self.items?.map{$0.badgeColor} ?? []
        }
    }
    
    
    
    var bee_colorNormals:[UIColor?] {
        set{
            self.bee.setTitle(newValue, key: .foregroundColor, for: .normal)
        }
        get{
            return self.bee.getTitle(.foregroundColor, for: .normal)
        }
    }
    
    
    var bee_colorSelecteds:[UIColor?] {
        set{
            self.bee.setTitle(newValue, key: .foregroundColor, for: .selected)
        }
        get{
            return self.bee.getTitle(.foregroundColor, for: .selected)
        }
    }
    
    
    var bee_colorHighlighteds:[UIColor?] {
        set{
            self.bee.setTitle(newValue, key: .foregroundColor, for: .highlighted)
        }
        get{
            return self.bee.getTitle(.foregroundColor, for: .highlighted)
        }
    }
    
    var bee_fontNormals:[UIFont?] {
        set{
            self.bee.setTitle(newValue, key: .font, for: .normal)
        }
        get{
            return self.bee.getTitle(.font, for: .normal)
        }
    }
    
    
    var bee_fontSelecteds:[UIFont?] {
        set{
            self.bee.setTitle(newValue, key: .font, for: .selected)
        }
        get{
            return self.bee.getTitle(.font, for: .selected)
        }
    }
    
    
    var bee_fontHighlighteds:[UIFont?] {
        set{
            self.bee.setTitle(newValue, key: .font, for: .highlighted)
        }
        get{
            return self.bee.getTitle(.font, for: .highlighted)
        }
    }
    
    //MARK:--- badge ----------
    
    @available(iOS 10.0, *)
    var bee_badgeColorNormals:[UIColor?] {
        set{
            self.bee.setBadge(newValue, key: .foregroundColor, for: .normal)
        }
        get{
            return self.bee.getBadge(.foregroundColor, for: .normal)
        }
    }
    
    @available(iOS 10.0, *)
    var bee_badgeColorSelecteds:[UIColor?] {
        set{
            self.bee.setBadge(newValue, key: .foregroundColor, for: .selected)
        }
        get{
            return self.bee.getBadge(.foregroundColor, for: .selected)
        }
    }
    
    @available(iOS 10.0, *)
    var bee_badgeColorHighlighteds:[UIColor?] {
        set{
            self.bee.setBadge(newValue, key: .foregroundColor, for: .highlighted)
        }
        get{
            return self.bee.getBadge(.foregroundColor, for: .highlighted)
        }
    }
    
    @available(iOS 10.0, *)
    var bee_badgeFontNormals:[UIFont?] {
        set{
            self.bee.setBadge(newValue, key: .font, for: .normal)
        }
        get{
            return self.bee.getBadge(.font, for: .normal)
        }
    }
    @available(iOS 10.0, *)
    var bee_badgeFontSelecteds:[UIFont?] {
        set{
            self.bee.setBadge(newValue, key: .font, for: .selected)
        }
        get{
            return self.bee.getBadge(.font, for: .selected)
        }
    }
    @available(iOS 10.0, *)
    var bee_badgeFontHighlighteds:[UIFont?] {
        set{
            self.bee.setBadge(newValue, key: .font, for: .highlighted)
        }
        get{
            return self.bee.getBadge(.font, for: .highlighted)
        }
    }
    
    
}
