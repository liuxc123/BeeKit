//
//  ViewController.swift
//  BeeKit
//
//  Created by liuxc123 on 12/31/2020.
//  Copyright (c) 2020 liuxc123. All rights reserved.
//

import UIKit
import BeeKit

class ViewController: UITableViewController, RefreshControllable, Refreshable {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Main"
        view.backgroundColor = .white

        self.bee.setupRefresh(self, tableView)
        tableView.bee.headerNormal { [weak self] in
            log.info("headerNormal")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.loadData()
            }
        }
        .footerAuto { [weak self] in
            log.info("footerAuto")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.loadData()
            }
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigator.push("app://test")
    }

    func loadData() {

//        NetworkManager.default.provider
//            .rx
//            .request(MultiTarget.target(Api.category))
//            .map(BaseModel<ListData>.self)
//            .map {$0.data.list}
//            .subscribe(onSuccess: { [weak self] (list) in
//                log.info(list)
//                self?.bee.refreshStatus([.tEndRefresh(true)])
//            }, onError: { [weak self] (error) in
//                log.info(error.localizedDescription)
//                self?.bee.refreshStatus([.tEndRefresh(true)])
//            })
//            .disposed(by: disposeBag)


        NetworkManager.default.provider
            .rx
            .onCache(MultiTarget(Api.category))
            .distinctUntilChanged()
            .map(BaseModel<ListData>.self)
            .map {$0.data.list}
            .subscribe(onNext: { [weak self] (list) in
                log.info(list)
                self?.bee.refreshStatus([.tEndRefresh(true)])
            }, onError: { [weak self] (error) in
                log.info(error.localizedDescription)
                self?.bee.refreshStatus([.tEndRefresh(true)])

            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: StatefulViewable {
    
    func hasContent() -> Bool {
        return false
    }
}

enum Api {
    case category
}

extension Api: SugarTargetType {
    var parameters: Parameters? {
        return nil
    }

    var sampleData: Data {
        return "".data(using: .utf8)!
    }

    var baseURL: URL {
        return URL(string: "https://app.sports.qq.com")!
    }

    var route: Route {
        return .get("/match/columnsV45?appvid=5.9.7&deviceId=F63F3976B00144C0B9F4F5963A2B2AFE&frontVersion=22c30dd2960cd32aaf76a3994918329a&guid=F63F3976B00144C0B9F4F5963A2B2AFE&hardware=iPhone8,1&height=1334&idfa=F129DC0D-6982-4A01-B2D2-5E63B4753BD0&idfv=F63F3976-B001-44C0-B9F4-F5963A2B2AFE&network=wifi&omgbizid=6200b2139c75c143700acb6c4ebbdc14474a0130113805&omgid=39bc6ea6065f8c4bb1cb76d6699de073d9e70010111318&os=iphone&osvid=11.4.1&width=750")
    }

    var headers: [String : String]? {
        return [:]
    }
}



struct BaseModel<T: Codable>: Codable {
    var code: Int
    var data: T
}

struct ListData: Codable {
    let list: [List]
}

struct List: Codable {
    let name: String
    let icon: String
    let columnId: String
    let rankColumn: String
    let type: String
    let require: String
}
