//
//  BEEKItDetailsViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit_Swift
import Schedule
import BEETableKit

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

class BEETimerViewController: TableViewController {

    var dataSource: [Date] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEETimer"

        var array: [Date] = []
         (1..<30).forEach { (index) in
            array.append(Date.now().adding(.minute, value: index))
        }
        dataSource = array
        setupForm()
    }

    func setupForm() {

        let section = TableSection()

        for data in dataSource {
            let row = TableRow<TimerListTableViewCell>(value: data)
            section.append(row: row)
        }
        tableDirector.append(section: section)
    }
}

final class TimerListTableViewCell: UITableViewCell, ConfigurableCell {

    var task: Schedule.Task?

    static var defaultHeight: CGFloat? {
        return 50
    }

    func configure(with data: Date) {
        accessoryType = .disclosureIndicator
        detailTextLabel?.text = nil
        setupTime(data: data)
        task = Plan.every(1.second).do { [weak self] (task) in
            self?.setupTime(data: data)
        }
    }

    func setupTime(data: Date) {
        let count = data.secondsSince(Date.now()).int
        textLabel?.text = count.string
        if count <= 0 {
            task?.cancel()
            textLabel?.text = "已完成"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.theme.backgroundColor = UIColorTheme(.backgroundColor)
        self.textLabel?.theme.textColor = UIColorTheme(.onPrimaryColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        task = nil
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            hud.mode = .determinate
            hud.progress = 0.3
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            hud.mode = .determinate
            hud.progress = 0.7
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            hud.mode = .determinate
            hud.progress = 0.9
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            BEEHUD.showSuccess(message: "Success")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
            BEEHUD.showInfo(message: "Info")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 16) {
            BEEHUD.showError(message: "Error")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 19) {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                    self?.content = true
                    self?.bee.refreshStatus([.endRefresh(false)])
                    self?.bee.endLoading()
                }
            }
            .footerAuto { [weak self] in
                self?.startLoading()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
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

class BEEInputViewController: ViewController, UISearchBarDelegate, UITextViewDelegate, UITextFieldDelegate {

    lazy var textField: LimitTextField = {
        let textField = LimitTextField()
        textField.placeholder = "placeholder"
        textField.clearButtonMode = .whileEditing
        textField.theme.textColor = UIColorTheme(.onPrimaryColor)
        textField.theme.backgroundColor = UIColorTheme(.backgroundColor)
        textField.wordLimit = 5
        textField.emojiLimit = true
        textField.limitDelegate = self
        textField.setTextDidChangeEvent { (text) in
            print(text)
        }

        return textField
    }()

    lazy var textView: LimitTextView = {
        let textView = LimitTextView()
        textView.placeholder = "placeholder"
        textView.isScrollEnabled = false
        textView.wordLimit = 20
        textView.emojiLimit = true
        textView.theme.backgroundColor = UIColorTheme(.backgroundColor)
        textView.theme.textColor = UIColorTheme(.onPrimaryColor)
        textView.placeholderLabel.theme.textColor = UIColorTheme(.placeholderTextColor)
        textView.limitDelegate = self
        textView.setTextDidChangeEvent { (text) in
            print(text)
        }
        return textView
    }()

    lazy var searchBar: LimitSearchBar = {
        let searchBar = LimitSearchBar()
        searchBar.isEnbleOldStyleBefore11 = true
        searchBar.theme.backgroundColor = UIColorTheme(.backgroundColor)
        searchBar.wordLimit = 5
        searchBar.emojiLimit = true
        searchBar.limitDelegate = self
        searchBar.setTextDidChangeEvent { (text) in
            print(text)
        }
        return searchBar
    }()

    lazy var searchBar2: LimitSearchBar = {
        let searchBar = LimitSearchBar()
        searchBar.isEnbleOldStyleBefore11 = false
        searchBar.theme.backgroundColor = UIColorTheme(.backgroundColor)
        searchBar.wordLimit = 5
        searchBar.emojiLimit = true
        searchBar.limitDelegate = self
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
        view.addSubview(searchBar2)

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

        searchBar2.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
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
        imageView.theme.image = ThemeProvider<UIImage>({ (style) -> UIImage in
            return UIImage.iconfont(BEEIconFont.tback(50), color: UIColorTheme(style, level: .onPrimaryColor))
        })
        imageView.contentMode = .center
        view.addSubview(imageView)

    }
}

class BEEThemeViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEETheme"
        self.navigation.bar.theme.titleTextAttributes = ThemeProvider<[NSAttributedString.Key : Any]>({ style in
            return [.font: UIFontMake(17), .foregroundColor: UIColorTheme(style, level: .onPrimaryColor)]
        })
        self.navigation.bar.theme.backgroundColor = UIColorTheme(.backgroundColor)
        self.navigation.bar.theme.tintColor = UIColorTheme(.onPrimaryColor)
        self.navigation.item.backBarButtonItem = UIBarButtonItem(image: UIImage.iconfont(BEEIconFont.tback(24), color: .black), style: .done, target: nil, action: nil)
        self.navigation.item.rightBarButtonItem = UIBarButtonItem(title: "切换主题", style: .done, target: self, action: #selector(changeTheme))

        let label = UILabel(frame: CGRect(x: 0, y: 88, width: view.bounds.width, height: 300))
        label.textAlignment = .center
        view.addSubview(label)

        label.theme.backgroundColor = ThemeProvider<UIColor>({ style in
            switch style {
            case .dark:
                return .blue
            default:
                return .yellow
            }
        })
        label.theme.attributedText = ThemeProvider<NSAttributedString>({ style in
            return "文本内容".withFont(UIFontMake(17)).withTextColor(UIColorTheme(style, level: .onPrimaryColor))
        })
    }

    @objc func changeTheme() {
        let currentTheme = ThemeManager.shared.currentThemeStyle
        ThemeManager.shared.changeTheme(to: currentTheme == .light ? .dark : .light)
    }
}

class BEELabelViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "BEELabel"

        let label = BEELabel()
        label.textInsets = UIEdgeInsets(inset: 20)
        label.numberOfLines = 0
        label.text = "自适应呢绒自适应呢绒自适应呢绒自适应呢绒自适应呢绒自适应呢绒自适应呢绒自适应呢绒自适应呢绒自适应呢绒自适应呢绒自适应呢绒"
        label.theme.textColor = UIColorTheme(.onPrimaryColor)
        view.addSubview(label)

        label.snp.makeConstraints { (make) in
            make.top.equalTo(88) 
            make.left.right.equalToSuperview()
        }
    }
}
