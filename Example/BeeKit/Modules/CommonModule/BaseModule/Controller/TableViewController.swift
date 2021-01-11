//
//  TableViewController.swift
//  CommonApp
//
//  Created by liuxc on 2020/12/21.
//

import UIKit
import BeeKit
import BEETableKit

class TableViewController: ViewController {

    // MARK: UI

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()

    lazy var tableDirector: TableDirector = {
        return TableDirector(tableView: tableView)
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.pin.top(view.pin.safeArea).horizontally().bottom()
    }

    // MARK: - Setup

    override func setupUI() {
        self.view.addSubview(tableView)
    }

    override func setupTheme() {
        super.setupTheme()
        tableView.theme.backgroundColor = UIColorTheme(.backgroundColor)
    }
}

