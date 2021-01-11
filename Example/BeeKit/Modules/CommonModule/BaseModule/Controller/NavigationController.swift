//
//  AUNavigationController.swift
//  ModuleProject
//
//  Created by liuxc on 2020/4/6.
//  Copyright © 2020 liuxc. All rights reserved.
//

import UIKit

open class NavgationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }

    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }

    open override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }

    open override var childForHomeIndicatorAutoHidden: UIViewController? {
        return topViewController
    }

    open override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        return topViewController
    }

    open override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? false
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .portrait
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }

    deinit { print("deinit:\t\(classForCoder)") }

}

extension NavgationController : UIGestureRecognizerDelegate {

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                return false
            }
        }
        return true
    }
}
