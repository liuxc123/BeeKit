//
//  BEEKItDetailsViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class BEEAppViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEEApp"

        log.verbose("App name: \(BEEApp.name)")
        log.verbose("App build: \(BEEApp.build)")
        log.verbose("App version: \(BEEApp.version)")
        log.verbose("App set: \(BEEApp.setAppSetting(object: "Test", forKey: "Test"))")
        log.verbose("App get: \(BEEApp.getAppSetting(objectKey: "Test") ?? "")")

        BEEApp.onFirstStart { isFirstStart in
            if isFirstStart {
                log.verbose("Is first start!")
            } else {
                log.verbose("Is not first start!")
            }
        }
    }
}

class BEELogViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEELog"

        log.verbose("verbose log")
        log.info("info log")
        log.error("error log")
        log.warning("warning log")
    }
}

class BEEBiometricsViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BFBiometrics"

        BEEBiometrics.useBiometric(localizedReason: "This is a test", completion: { result in
            runOnMainThread {
                if result == .success {
                    BEEHUD.showToast(message: "Success", view: self.view)
                } else {
                    BEEHUD.showToast(message: "\(result.rawValue)", view: self.view)
                }
            }
        })
    }
}

class BEETimerViewController: ViewController {

    deinit {
        Time.remove("BEETimerViewController_timer")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEETimer"

        let remainTime = Time.remainTime(Date.now().adding(.day, value: 2))
        Time.make(.callBack("BEETimerViewController_timer", remainTime, 1, { (model) in
            log.verbose("\(model.month)月\(model.day)天\(model.hour)时\(model.minute)分\(model.second)秒")
        }))
    }
}

class BEEDataStructuresViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEEDataStructures"

        var stack = Stack<String>()
        stack.push("1")
        stack.push("2")
        log.verbose("Push: 1\nPush: 2\nStack: \(stack)")
        let removed = stack.pop()
        log.verbose("Pop: \(removed!) \nStack: \(stack)")
        stack.empty() ? log.verbose("Is empty") : log.verbose("Is not empty")

        var list: List = List<String>()
        list.insert("1")
        list.insert("2")
        list.insert("3")
        log.verbose("\n\nInsert: 1\nInsert: 2\nInsert: 3\nList: \(list)")
        log.verbose("Search index 0: \(list.search(at: 0)!)")
        let search = list.search("3")
        log.verbose("Search object \"3\": \(search)")
        let deleted = list.delete("3")
        log.verbose("Delete: 3 - \(deleted) \nList: \(list)")
        list.delete(at: 0)
        log.verbose("Delete index: 0\nList: \(list)")

        var queue: Queue = Queue<String>()
        queue.enqueue("1")
        queue.enqueue("2")
        queue.enqueue("3")
        log.verbose("\n\nEnqueue: 1\nEnqueue: 2\nEnqueue: 3\nQueue: \(queue)")
        log.verbose("Top: \(queue.top()!)")
        let dequeued = queue.dequeue()
        log.verbose("Dequeue \(dequeued) \nQueue: \(queue)")
        queue.empty()
        log.verbose("Empty queue: \(queue)")

    }
}

class BEESystemSoundViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEESystemSound"

        BEESystemSound.vibrate()
        log.verbose("Vibrate")
        BEESystemSound.playSystemSound(audioID: .receivedMessage)
        log.verbose("Play sound")
    }
}


class BEEPasswordViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEEPassword"

        let pass1 = "Password"
        let passLevel1 = BEEPassword.strength(password: pass1)
        log.verbose("Password: \(pass1) - Level: \(passLevel1.rawValue) of \(BEEPassword.PasswordStrengthLevel.verySecure.rawValue)")
        let pass2 = "kqi019ASC.v1|!-2"
        let passLevel2 = BEEPassword.strength(password: pass2)
        log.verbose("Password: \(pass2) - Level: \(passLevel2.rawValue) of \(BEEPassword.PasswordStrengthLevel.verySecure.rawValue)")
    }
}

class BEELinearViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEELinearView"

        let linearView = LinearView()
        linearView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        linearView.layer.shadowOffset = .zero
        linearView.layer.shadowRadius = 20
        linearView.layer.shadowOpacity = 0.2
        view.addSubview(linearView)

        linearView.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.center.equalToSuperview()
        }

        let a = UIView()
        a.backgroundColor = .random
        a.snp.makeConstraints { (make) in
            make.height.equalTo(100)
        }

        let b = UIView()
        b.backgroundColor = .random
        b.snp.makeConstraints { (make) in
            make.height.equalTo(100)
        }

        let c = UIView()
        c.backgroundColor = .random
        c.snp.makeConstraints { (make) in
            make.height.equalTo(100)
        }

        linearView.layout(.vertical)
            .view(a)
            .spacing(10)
            .view(b)
            .spacing(20, mode: .follow)
            .view(c)
            .done()

        Time.delay(5) {
            UIView.animate(withDuration: 0.3) {
                b.isHidden = true
            }
        }
    }
}

class BEEHUDViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEEHUD"

        let hud = BEEHUD.showLoading()

        Time.delay(3) {
            hud.mode = .determinate
            hud.progress = 0.3
        }

        Time.delay(6) {
            hud.mode = .determinate
            hud.progress = 0.7
        }

        Time.delay(9) {
            hud.mode = .determinate
            hud.progress = 0.9
        }

        Time.delay(10) {
            BEEHUD.showSuccess(message: "Success")
        }

        Time.delay(13) {
            BEEHUD.showInfo(message: "Info")
        }

        Time.delay(16) {
            BEEHUD.showError(message: "Error")
        }

        Time.delay(18) {
            BEEHUD.showToast(message: "toast")
        }

    }
}


class BEERefreshableViewController: TableViewController, Refreshable, RefreshControllable, StatefulViewable {

    var content: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Refreshable and StatefulViewable"

        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        emptyView.backgroundColor = .blue
        self.bee.emptyView = emptyView

        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        loadingView.backgroundColor = .yellow
        self.bee.loadingView = loadingView

        let errorView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        errorView.backgroundColor = .red
        self.bee.errorView = errorView

        self.bee.setupRefresh(self, tableView)

        tableView.bee
            .headerNormal { [weak self] in
                self?.startLoading()
                Time.delay(3) { [weak self] in
                    self?.content = true
                    self?.bee.refreshStatus([.endRefresh(false)])
                    self?.bee.endLoading()
                }
            }
            .footerAuto { [weak self] in
                self?.startLoading()
                Time.delay(3) { [weak self] in
                    self?.content = false
                    self?.bee.refreshStatus([.endRefresh(false)])
                    self?.bee.endLoading(animated: true, error: NSError(domain: "error", code: 300, userInfo: nil))
                }
            }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupInitialViewState()
        self.bee.refreshStatus([.beginRefresh])
    }

    var backingView: UIView {
        return tableView
    }

    func hasContent() -> Bool {
        return content
    }
}

class BEEInputViewController: ViewController, UISearchBarDelegate {

    lazy var textField: LimitTextField = {
        let textField = LimitTextField()
        textField.placeholder = "placeholder"
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .yellow

        textField.wordLimit = 5
        textField.emojiLimit = true
        textField.setTextDidChangeEvent { (text) in
            print(text)
        }

        return textField
    }()

    lazy var textView: LimitTextView = {
        let textView = LimitTextView()
        textView.placeholder = "placeholder"
        textView.backgroundColor = .yellow
        textView.isScrollEnabled = false
        textView.wordLimit = 5
        textView.emojiLimit = true
        textView.setTextDidChangeEvent { (text) in
            print(text)
        }
        return textView
    }()

    lazy var searchBar: LimitSearchBar = {
        let searchBar = LimitSearchBar()
        searchBar.wordLimit = 5
        searchBar.emojiLimit = true
        searchBar.setTextDidChangeEvent { (text) in
            print(text)
        }
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEEInput"

        view.addSubview(textField)
        view.addSubview(textView)
        view.addSubview(searchBar)

        textField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(88)
            make.height.equalTo(50)
        }

        textView.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(50)
        }

        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(50)
        }
    }
}

class BEEIconFontViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEEIconFont"

        let imageView = UIImageView(frame: CGRect(x: 0, y: 88, width: view.bounds.width, height: 300))
        imageView.iconfont(BEEIconFont.tback(50))
        imageView.contentMode = .center
        view.addSubview(imageView)
    }
}
