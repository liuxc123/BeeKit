//
//  BeeExtension+.swift
//  BeeKit
//
//  Created by liuxc on 2021/1/4.
//

import Foundation

//MARK:--- 打印 ----------
public var bee_printOpen:Bool = true
#if DEBUG
public func print_bee(_ items: Any..., file:Any = #file, function:Any = #function, line: Any = #line){
    guard bee_printOpen else { return }
    debugPrint("---👉👉👉")
    debugPrint(file, function, line)
    debugPrint(items)
    debugPrint("----------  👻")
}
#else
public func print_bee(_ items: Any...){}
#endif

#if DEBUG
public func print_address(_ value:AnyObject){
    guard bee_printOpen else { return }
    debugPrint("---👉👉👉 内存地址-->", value)
    debugPrint(Unmanaged.passUnretained(value).toOpaque())
    debugPrint("---------- 👻")
}
#else
public func print_address(_ value:AnyObject){}
#endif

//MARK:--- 耗时 ----------
/// 耗时
public func bee_timeConsuming(_ name:String = " 👻👉👉耗时：", call:(()->Void)? = nil) {
    //let startTime = CFAbsoluteTimeGetCurrent()
    //let endTime = CACurrentMediaTime()
    let start = CACurrentMediaTime()
    call?()
    let end = CACurrentMediaTime()
    print_bee(name, String(format: "%.7f", (end - start)*1000))
}

public struct BEE {

    public static var window:UIWindow? {
        return UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow ?? nil
    }

    public static var screenSize:CGSize {
        return UIScreen.main.bounds.size
    }

    public static var screenW:CGFloat {
        return UIScreen.main.bounds.size.width
    }

    public static var screenH:CGFloat {
        return UIScreen.main.bounds.size.height
    }

    public static var sysNavigationH:CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.statusBarFrame.size.height + (UIViewController.topMost?.navigationController?.navigationBar.frame.size.height ?? 44)
        } else {
            return 20.0 + (UIViewController.topMost?.navigationController?.navigationBar.frame.size.height ?? 44)
        }
    }

    public static var sysTabBarH:CGFloat {
        return UIViewController.topMost?.tabBarController?.tabBar.frame.size.height ?? 59
    }

    public static var sectionMinH:CGFloat {
        return 0.001
    }

    public static var sysVersion:String {
        return UIDevice.current.systemVersion
    }

    public static var isSimulator:Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    public static var notice:NotificationCenter {
        return NotificationCenter.default
    }

    public static var userde:UserDefaults {
        return UserDefaults.standard
    }

    public static var timestampNow: TimeInterval {
        return Date.now().timeIntervalSince1970
    }

    public static var appVersion:String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    public static var appId:String {
        return Bundle.main.bundleIdentifier ?? ""
    }

    public static func appUrlScheme(_ match:String) -> String {
        guard let info = Bundle.main.infoDictionary else { return match }
        let urlTypes = info.arrayValue("CFBundleURLTypes")
        for item in urlTypes {
            guard let j = item as? [String:Any] else { continue }
            guard let s = j.arrayValue("CFBundleURLSchemes").first as? String else { continue }
            guard s.hasPrefix(match) else { continue }
            return s
        }
        return match
    }

    /// app 安装日期
    public static var appCreatDate:Date? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return nil
        }
        guard let dates = try? FileManager.default.attributesOfItem(atPath: url.path) else {
            return nil
        }
        return dates[FileAttributeKey.creationDate] as? Date ?? nil
    }
    /// app 更新日期
    public static var appUpdateDate:Date? {
        guard let info = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            return nil
        }
        let url = URL(fileURLWithPath: info, isDirectory: true)
        let path = url.deletingLastPathComponent().relativePath
        guard let dates = try? FileManager.default.attributesOfItem(atPath: path) else {
            return nil
        }
        return dates[FileAttributeKey.modificationDate] as? Date ?? nil
    }

    public static func classFrom(string name: String, forClass: AnyClass? = nil) -> AnyClass? {
        let bundle = forClass == nil ? Bundle.main : Bundle(for: forClass!)
        guard let app:String = bundle.infoDictionary!["CFBundleExecutable"] as? String else {
            // 命名空间不存在
            return NSClassFromString(name)
        }
        // 2.通过命名空间和类名转换成类
        let str = "_TtC\(app.count)\(app)\(name.count)\(name)"
        let cla:AnyClass? = NSClassFromString(str)
        return cla
    }
    
}
