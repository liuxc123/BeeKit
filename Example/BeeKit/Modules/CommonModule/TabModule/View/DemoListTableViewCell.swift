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
}
