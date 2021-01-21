//
//  WebViewController.swift
//  ModuleProject
//
//  Created by liuxc on 2020/4/6.
//  Copyright © 2020 liuxc. All rights reserved.
//

import UIKit
import BeeKit_Swift
import WebKit
import RxSwift
import RxCocoa
import RxWebKit
import SnapKit

class WebViewController: ViewController {

    // MARK: Properties

    var url: URL!
    let callback: CallBackBlock?

    /// 网页
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        if #available(iOS 9.0, *) {
            webView.allowsLinkPreview = true
        }
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()

    /// 加载进度条
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 2))
        progressView.trackTintColor = .white
        progressView.theme.progressTintColor = UIColorTheme(.primaryColor)
        return progressView
    }()

    /// 返回按钮
    lazy var backBarItem: UIBarButtonItem = {
        let backImage = UIImage(named: "nav_back_icon")
        let barItem = UIBarButtonItem(image: backImage, style: .done, target: nil, action: nil)
        return barItem
    }()


    /// 关闭按钮
    lazy var closeBarItem: UIBarButtonItem = {
        let closeImage = UIImage(named: "nav_close_icon")
        let barItem = UIBarButtonItem(image: closeImage, style: .done, target: nil, action: nil)
        return barItem
    }()

    // MARK: - Initializing

    init(url: URL, callback: CallBackBlock? = nil) {
        self.url = url
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lift Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.loadWebPage()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.callback?([:])
    }

    // MARK: - Setup

    override func setupUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
    }

    override func setupTheme() {
        super.setupTheme()
        view.theme.backgroundColor = UIColorTheme(.backgroundColor)
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigation.bar.additionalView = progressView
    }

    override func setupLayout() {
        webView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }


    // MARK: - Bind

    func bind() {

        webView.rx.title
            .share(replay: 1)
            .subscribe(onNext: { [weak self] title in
                self?.navigation.item.title = title
            })
            .disposed(by: disposeBag)

        webView.rx.url
            .share(replay: 1)
            .subscribe(onNext: {
                log.debug("[URL]: \($0?.absoluteString ?? "")")
            })
            .disposed(by: disposeBag)

        webView.rx.estimatedProgress
            .share(replay: 1)
            .map { Float($0) }
            .subscribe(onNext: { [weak self] (progress) in
                self?.progressView.setProgress(progress, animated: true)
                if self?.progressView.progress == 1 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                        self?.progressView.setProgress(0.0, animated: false)
                    }
                }
            })
            .disposed(by: disposeBag)


        webView.rx.canGoBack
            .share(replay: 1)
            .subscribe(onNext: { [weak self] canGoBack in
                guard let self = self else { return }
                self.navigation.item.leftBarButtonItems = canGoBack ? [self.backBarItem, self.closeBarItem] : [self.backBarItem]
            })
            .disposed(by: disposeBag)

        webView.rx.didStartProvisionalNavigation
            .subscribe(onNext: { [weak self] webView, navigation in
                self?.progressView.setProgress(0.0, animated: false)
            })
            .disposed(by: disposeBag)

        webView.rx.didFailNavigation
            .subscribe(onNext: { [weak self] webView, navigation, error in
                log.error(error.localizedDescription)
                self?.progressView.setProgress(0.0, animated: false)
            })
            .disposed(by: disposeBag)

        // Alert Panel

        webView.rx.javaScriptAlertPanel
            .subscribe(onNext: { [weak self] webView, message, frame, handler in
                let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
                    // We must call back js
                    handler()
                }))
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        webView.rx.javaScriptConfirmPanel
            .subscribe(onNext: { [weak self] webView, message, frame, handler in
                let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                    handler(false)
                }))
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
                    handler(true)
                }))
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        backBarItem.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                if self.webView.canGoBack {
                    self.webView.goBack()
                } else {
                    if self.navigationController?.viewControllers.count ?? 0 > 1 {
                        self.navigationController?.popViewController()
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
            .disposed(by: disposeBag)

        closeBarItem.rx.tap
            .subscribe(onNext: {
                navigator.popViewController(true)
            })
            .disposed(by: disposeBag)

    }

    // MARK: - Event Response

    public func loadWebPage() {
        if let urlAddress = webView.url ?? url {
            let request = URLRequest(url: urlAddress)
            webView.load(request as URLRequest)
        }
    }

    @objc func refreshAction() {
        webView.reload()
    }
}


extension WebViewController: StatefulViewable {

    func hasContent() -> Bool {
        return false
    }

    var backingView: UIView {
        return webView
    }

}
