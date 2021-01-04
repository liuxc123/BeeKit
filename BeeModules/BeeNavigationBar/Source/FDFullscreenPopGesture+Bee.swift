//
//  FDFullscreenPopGesture+Bee.swift
//  BeeKit
//
//  Created by liuxc on 2021/1/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public extension Bee where Base: UINavigationController {
    /// 导航栏滑动手势、处理用户的侧滑弹出操作
    var gestureRecognizer:UIPanGestureRecognizer {
        get{
            return base.fd_fullscreenPopGestureRecognizer
        }
    }
    ///视图控制器可以自己控制，而不是全局的方式控制，导航栏的外观。，默认是YES
    var navigationBarAppearanceEnabled:Bool {
        get{
            return base.fd_viewControllerBasedNavigationBarAppearanceEnabled
        }
    }
    ///视图控制器可以自己控制，而不是全局的方式控制，导航栏的外观。，默认是YES
    @discardableResult
    func navigationBar(appearanceEnabled b: Bool) -> Bee {
        base.fd_viewControllerBasedNavigationBarAppearanceEnabled = b
        return self
    }
}

public extension Bee where Base: UIViewController {
    ///viewcontroller的侧滑功能是否禁用 默认启用
    var popDisabled:Bool {
        get{
            return base.fd_interactivePopDisabled
        }
    }
    ///viewcontroller的侧滑功能是否禁用 默认启用
    @discardableResult
    func pop(disabled b: Bool) -> Bee {
        base.fd_interactivePopDisabled = b
        return self
    }
    /// 导航栏是否隐藏
    var navigationBarHidden:Bool {
        get{
            return base.fd_prefersNavigationBarHidden
        }
    }
    /// 导航栏是否隐藏
    @discardableResult
    func navigationBar(hidden b: Bool) -> Bee {
        base.fd_prefersNavigationBarHidden = b
        return self
    }
}

