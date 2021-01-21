//
//  CommonNavigationMap.swift
//  CommonApp
//
//  Created by liuxc on 2020/10/14.
//

import UIKit
import BeeKit_Swift

struct CommonNavigationMap {

    /// 注册页面
    static func initialize(navigator: NavigatorType) {

        // 内部网页跳转
        navigator.register("http://<path:_>", self.webViewControllerFactory)
        navigator.register("https://<path:_>", self.webViewControllerFactory)

        // Alert提示
        navigator.handle("alert".formatScheme(), self.alert(navigator: navigator))

        // test页面
        navigator.register("test".formatScheme()) { (url, values, context) -> UIViewController? in
            let vc = TestViewController()
            return vc
        }

        // 异常处理
        navigator.handle("<path:_>".formatScheme()) { (url, values, context) -> Bool in
            log.debug("[Navigator] NavigationMap.\(#function):\(#line) - global fallback function is called")

            let alertController = UIAlertController(title: "提示", message: "内容不匹配", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "确定", style: .destructive, handler: nil))
            navigator.present(alertController)
            return true
        }
    }

    private static func webViewControllerFactory(
        url: BeeKit_Swift.URLConvertible,
        values: [String: Any],
        context: Any?
    ) -> UIViewController? {
        guard let url = url.urlValue else { return nil }
        return WebViewController(url: url, callback: context as? CallBackBlock)
    }

    private static func alert(navigator: NavigatorType) -> URLOpenHandlerFactory {
        return { url, values, context in
            guard let title = url.queryParameters["title"] else { return false }
            let message = url.queryParameters["message"]
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "确定", style: .destructive, handler: nil))
            navigator.present(alertController)
            return true
        }
    }

}

