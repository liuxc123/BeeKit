//
//  TestViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Test"
        view.backgroundColor = .yellow
    }
    
}

class TestCell: UICollectionViewCell, FormConfigurableCell {

    static var estimatedSize: FormItemLayoutSize {
        return .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
    }

    func configure(with text: String) {

    }

}

class TestTableCell: UITableViewCell, TableConfigurableCell {

    static var estimatedHeight: CGFloat? {
        return 50
    }

    func configure(with text: String) {

    }

}
