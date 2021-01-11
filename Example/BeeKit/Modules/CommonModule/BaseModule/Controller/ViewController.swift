//
//  ViewController.swift
//  ModuleProject
//
//  Created by liuxc on 2020/4/6.
//  Copyright © 2020 liuxc. All rights reserved.
//  ViewController基类

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    // MARK: - Properties

    var disposeBag = DisposeBag()

    // MARK: - Initializing

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        hidesBottomBarWhenPushed = true
    }

    deinit { print("deinit:\t\(classForCoder)") }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupUI()
        setupTheme()
        setupNavigationBar()
        setupLayout()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // MARK: - Setup

    open func setupUI() {
        /// 子类重写
    }

    open func setupTheme() {
        view.theme.backgroundColor = UIColorTheme(.backgroundColor)
    }

    open func setupNavigationBar() {
        /// 子类继承
    }

    open func setupNotification() {

    }

    // MARK: - Layout

    open func setupLayout() {
        /// 子类重写
    }

    // MARK: - Bind
    

    // MARK: - Event Response


    // MARK: - Private Method


    // MARK: - Public Method
    

    // MARK: - Autorotate

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    // MARK: - HomeIndicator

    override var prefersHomeIndicatorAutoHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

