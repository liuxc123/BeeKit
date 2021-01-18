//
//  BEERootViewController.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

protocol EntryPresenterDelegate: class {
    var isResponsiveToTouches: Bool { set get }
    func displayPendingEntryOrRollbackWindow(dismissCompletionHandler: BEEPopupKit.DismissCompletionHandler?)
}

class BEERootViewController: UIViewController {

    // MARK: - Props

    private unowned let delegate: EntryPresenterDelegate

    private var lastAttributes: BEEAttributes!

    private let backgroundView = BEEBackgroundView()

    lazy var wrapperView: BEEWrapperView = {
        return BEEWrapperView()
    }()

    /*
     Count the total amount of currently displaying entries,
     meaning, total subviews less one - the backgorund of the entry
     */
    fileprivate var displayingEntryCount: Int {
        return view.subviews.count - 1
    }

    fileprivate var isDisplaying: Bool {
        return lastEntry != nil
    }

    private var lastEntry: BEEContentView? {
        return view.subviews.last as? BEEContentView
    }

    private var isResponsive = false {
        didSet {
            wrapperView.isAbleToReceiveTouches = isResponsive
            delegate.isResponsiveToTouches = isResponsive
        }
    }

    override var shouldAutorotate: Bool {
        if lastAttributes == nil {
            return true
        }
        return lastAttributes.positionConstraints.rotation.isEnabled
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let lastAttributes = lastAttributes else {
            return super.supportedInterfaceOrientations
        }
        switch lastAttributes.positionConstraints.rotation.supportedInterfaceOrientations {
        case .standard:
            return super.supportedInterfaceOrientations
        case .all:
            return .all
        }
    }

    // Previous status bar style
    private let previousStatusBar: BEEAttributes.StatusBar

    private var statusBar: BEEAttributes.StatusBar? = nil {
        didSet {
            if let statusBar = statusBar, ![statusBar, oldValue].contains(.ignored) {
                UIApplication.shared.set(statusBarStyle: statusBar)
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if [previousStatusBar, statusBar].contains(.ignored) {
            return super.preferredStatusBarStyle
        }
        return statusBar?.appearance.style ?? previousStatusBar.appearance.style
    }

    override var prefersStatusBarHidden: Bool {
        if [previousStatusBar, statusBar].contains(.ignored) {
            return super.prefersStatusBarHidden
        }
        return !(statusBar?.appearance.visible ?? previousStatusBar.appearance.visible)
    }

    // MARK: - Lifecycle

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(with delegate: EntryPresenterDelegate) {
        self.delegate = delegate
        previousStatusBar = .currentStatusBar
        super.init(nibName: nil, bundle: nil)
    }

    override public func loadView() {
        view = wrapperView
        view.insertSubview(backgroundView, at: 0)
        backgroundView.isUserInteractionEnabled = false
        backgroundView.fillSuperview()
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBar = previousStatusBar
    }

    // Set status bar
    func setStatusBarStyle(for attributes: BEEAttributes) {
        statusBar = attributes.statusBar
    }

    // MARK: - Setup

    func configure(entryView: BEEEntryView) {

        // In case the entry is a view controller, add the entry as child of root
        if let viewController = entryView.content.viewController {
            addChild(viewController)
        }

        // Extract the attributes struct
        let attributes = entryView.attributes

        // Assign attributes
        let previousAttributes = lastAttributes

        // Remove the last entry
        removeLastEntry(lastAttributes: previousAttributes, keepWindow: true)

        lastAttributes = attributes

        let entryContentView = BEEContentView(withEntryDelegate: self)
        view.addSubview(entryContentView)
        entryContentView.setup(with: entryView)

        switch attributes.screenInteraction.defaultAction {
        case .forward:
            isResponsive = false
        default:
            isResponsive = true
        }

        if previousAttributes?.statusBar != attributes.statusBar {
            setNeedsStatusBarAppearanceUpdate()
        }

        if shouldAutorotate {
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }

    // Check priority precedence for a given entry
    func canDisplay(attributes: BEEAttributes) -> Bool {
        guard let lastAttributes = lastAttributes else {
            return true
        }
        return attributes.precedence.priority >= lastAttributes.precedence.priority
    }

    // Removes last entry - can keep the window 'ON' if necessary
    private func removeLastEntry(lastAttributes: BEEAttributes?, keepWindow: Bool) {
        guard let attributes = lastAttributes else {
            return
        }
        if attributes.popBehavior.isOverriden {
            lastEntry?.removePromptly()
        } else {
            popLastEntry()
        }
    }

    // Make last entry exit using exitAnimation - animatedly
    func animateOutLastEntry(completionHandler: BEEPopupKit.DismissCompletionHandler? = nil) {
        lastEntry?.dismissHandler = completionHandler
        lastEntry?.animateOut(pushOut: false)
    }

    // Pops last entry (using pop animation) - animatedly
    func popLastEntry() {
        lastEntry?.animateOut(pushOut: true)
    }
}

// MARK: - UIResponder

extension BEERootViewController {

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch lastAttributes.screenInteraction.defaultAction {
        case .dismissEntry:
            lastEntry?.animateOut(pushOut: false)
            fallthrough
        default:
            lastAttributes.screenInteraction.customTapActions.forEach { $0() }
        }
    }
}

// MARK: - EntryScrollViewDelegate

extension BEERootViewController: EntryContentViewDelegate {

    func didFinishDisplaying(entry: BEEEntryView, keepWindowActive: Bool, dismissCompletionHandler: BEEPopupKit.DismissCompletionHandler?) {
        guard !isDisplaying else {
            return
        }

        guard !keepWindowActive else {
            return
        }

        delegate.displayPendingEntryOrRollbackWindow(dismissCompletionHandler: dismissCompletionHandler)
    }

    func changeToInactive(withAttributes attributes: BEEAttributes, pushOut: Bool) {
        guard displayingEntryCount <= 1 else {
            return
        }

        let clear = {
            let style = BEEBackgroundView.Style(background: .clear, displayMode: attributes.displayMode)
            self.changeBackground(to: style, duration: attributes.exitAnimation.totalDuration)
        }

        guard pushOut else {
            clear()
            return
        }

        guard let lastBackroundStyle = lastAttributes?.screenBackground else {
            clear()
            return
        }

        if lastBackroundStyle != attributes.screenBackground {
            clear()
        }
    }

    func changeToActive(withAttributes attributes: BEEAttributes) {
        let style = BEEBackgroundView.Style(background: attributes.screenBackground,
                                           displayMode: attributes.displayMode)
        changeBackground(to: style, duration: attributes.entranceAnimation.totalDuration)
    }

    private func changeBackground(to style: BEEBackgroundView.Style, duration: TimeInterval) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
                self.backgroundView.style = style
            }, completion: nil)
        }
    }
}

