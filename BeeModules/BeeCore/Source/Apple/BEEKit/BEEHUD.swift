import UIKit
import MBProgressHUD

public typealias BEEHUDMode = MBProgressHUDMode
public typealias BEEHUDAnimation = MBProgressHUDAnimation
public typealias BEEHUDBackgroundStyle = MBProgressHUDBackgroundStyle
public typealias BEEHUDCompletionBlock = MBProgressHUDCompletionBlock

public struct BEEHUDConfig {
    
    public static var shared = BEEHUDConfig()
    
    public var imageSucess: UIImage? = BEEHUD.bundleImage(by: "ic_tips_error")
    public var imageInfo: UIImage? = BEEHUD.bundleImage(by: "ic_tips_error")
    public var imageError: UIImage? = BEEHUD.bundleImage(by: "ic_tips_info")
    
    public var textColor: UIColor = UIColor.white
    public var textFont: UIFont = .systemFont(ofSize: 16)
    
    public var contentColor: UIColor = UIColor.white
    public var defaultDismissDuration: TimeInterval = 2.0
    public var offSetY: CGFloat = 0
    public var margin: CGFloat = 20
    public var isSquare: Bool = true
    public var minSize: CGSize = CGSize(width: 100, height: 100)
    public var cornerRadius: CGFloat = 5.0
    
    public var animationType: BEEHUDAnimation = .zoom
    public var backgroundStyle: BEEHUDBackgroundStyle = .solidColor
    public var backgroundColor: UIColor = UIColor.black

}

public class BEEHUD: MBProgressHUD {
    
    @discardableResult
    public static func showToast(
        message: String?,
        view: UIView,
        duration: TimeInterval? = nil,
        interaction: Bool = false
    ) -> BEEHUD {
        let config = BEEHUDConfig.shared
        let hud = show(view: view, message: message, interaction: false, animated: true)
        hud.mode = .text
        hud.offset = CGPoint(x: 0, y: config.offSetY)
        hud.isSquare = false
        hud.hide(animated: true, afterDelay: duration ?? config.defaultDismissDuration)
        return hud
    }

    @discardableResult
    public static func showLoading(
        message: String?,
        view: UIView,
        interaction: Bool = false
    ) -> BEEHUD {
        let hud = show(view: view, message: message, interaction: false, animated: true)
        hud.mode = .indeterminate
        return hud
    }
    
    @discardableResult
    public static func showSuccess(
        message: String?,
        view: UIView,
        duration: TimeInterval? = nil,
        interaction: Bool = false
    ) -> BEEHUD {
        let config = BEEHUDConfig.shared
        let hud = show(view: view, message: message, interaction: false, animated: true)
        hud.mode = .customView
        let imageView = UIImageView(image: config.imageSucess)
        hud.customView = imageView
        hud.hide(animated: true, afterDelay: duration ?? config.defaultDismissDuration)
        return hud
    }
    
    @discardableResult
    public static func showInfo(
        message: String?,
        view: UIView,
        duration: TimeInterval? = nil,
        interaction: Bool = false
    ) -> BEEHUD {
        let hud = show(view: view, message: message, interaction: false, animated: true)
        hud.mode = .customView
        let config = BEEHUDConfig.shared
        let imageView = UIImageView(image: config.imageInfo)
        hud.customView = imageView
        hud.hide(animated: true, afterDelay: duration ?? config.defaultDismissDuration)
        return hud
    }
    
    @discardableResult
    public static func showError(
        message: String?,
        view: UIView,
        duration: TimeInterval? = nil,
        interaction: Bool = false
    ) -> BEEHUD {
        let hud = show(view: view, message: message, interaction: false, animated: true)
        hud.mode = .customView
        let config = BEEHUDConfig.shared
        let imageView = UIImageView(image: config.imageError)
        hud.customView = imageView
        hud.hide(animated: true, afterDelay: duration ?? config.defaultDismissDuration)
        return hud
    }
    
    @discardableResult
    public static func showImage(
        image: UIImage?,
        message: String?,
        view: UIView,
        duration: TimeInterval? = nil,
        interaction: Bool = false
    ) -> BEEHUD {
        let hud = show(view: view, message: message, interaction: false, animated: true)
        hud.mode = .customView
        let config = BEEHUDConfig.shared
        let imageView = UIImageView(image: image)
        hud.customView = imageView
        hud.hide(animated: true, afterDelay: duration ?? config.defaultDismissDuration)
        return hud
    }
    
    @discardableResult
    public static func hide(for view: UIView) -> Bool {
        BEEHUD.hide(for: view, animated: true)
    }
    
    public static func hideAllHUD(for view: UIView) {
        for subview in view.subviews {
            if subview is MBProgressHUD {
                MBProgressHUD.hide(for: subview, animated: true)
            }
        }
    }
    
    private static func show(
        view: UIView,
        message: String? = nil,
        interaction: Bool = false,
        animated: Bool
    ) -> BEEHUD {
        
        MBProgressHUD.hide(for: view, animated: true)
        let config = BEEHUDConfig.shared
        let hud = BEEHUD.showAdded(to: view, animated: animated)
        if let message = message, !message.isEmpty {
            hud.label.text = message
            hud.label.textColor = config.textColor
            hud.label.font = config.textFont
        }
        hud.contentColor = config.contentColor
        hud.bezelView.style = config.backgroundStyle
        hud.bezelView.backgroundColor = config.backgroundColor
        hud.bezelView.cornerRadius = config.cornerRadius
        hud.animationType = config.animationType
        hud.isUserInteractionEnabled = !interaction
        hud.isSquare = config.isSquare
        hud.margin = config.margin
        return hud
    }
    
    static func bundleImage(by name: String) -> UIImage? {
        let resource_bundle = Bundle(path: Bundle(for: BEEHUD.self).resourcePath ?? "")
        return UIImage(named: name, in: resource_bundle, compatibleWith: nil)
    }
}
