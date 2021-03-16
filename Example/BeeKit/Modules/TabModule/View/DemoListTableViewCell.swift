//
//  DemoListTableViewCell.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEETableKit

final class DemoListTableViewCell: UITableViewCell, ConfigurableCell {

    static var defaultHeight: CGFloat? {
        return 50
    }

    func configure(with text: String) {
        accessoryType = .disclosureIndicator
        textLabel?.text = text
        detailTextLabel?.text = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.theme.backgroundColor = UIColorTheme(.backgroundColor)
        self.textLabel?.theme.textColor = UIColorTheme(.onPrimaryColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final class DemoListTableViewCell2: UITableViewCell, ConfigurableCell {

    static var defaultHeight: CGFloat? {
        return 50
    }

    func configure(with data: (String, UIColor)) {
        accessoryType = .disclosureIndicator
        textLabel?.text = data.0
        detailTextLabel?.text = nil
        self.backgroundColor = data.1
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
}
