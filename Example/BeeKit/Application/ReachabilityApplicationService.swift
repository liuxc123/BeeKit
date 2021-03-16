//
//  ReachabilityApplicationService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/3/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import RxSwift
import RxCocoa
import BeeKit_Swift
import Reachability
import RxReachability

class ReachabilityApplicationService: NSObject, ApplicationService {

    private let reachability = Reachability()
    private let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        setupReachability()
        startNotifier()
        
        return true
    }

    func setupReachability() {
        reachability?.rx.reachabilityChanged
          .subscribe(onNext: { reachability in
            log.info("Reachability changed: \(reachability.connection)")
          })
          .disposed(by: disposeBag)

        reachability?.rx.isConnected
          .subscribe(onNext: {
            log.info("Is connected")
          })
          .disposed(by: disposeBag)

        reachability?.rx.isDisconnected
          .subscribe(onNext: {
            log.info("网络连接已断开")
            BEEHUD.showToast(message: "网络连接已断开")
          })
          .disposed(by: disposeBag)
    }


    /// 开启网络监听
    func startNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            log.warning("Reachable Unable to start notifier")
        }
    }

    /// 关闭网络监听
    func stopNotifier() {
        reachability?.stopNotifier()
    }

    deinit {
         stopNotifier()
    }
}


