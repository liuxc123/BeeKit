//
//  CollectionViewController.swift
//  CommonApp
//
//  Created by liuxc on 2020/12/4.
//

import UIKit
import BEEFormKit

class CollectionViewController: ViewController {

    // MARK: UI

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()

    lazy var formDirector: FormDirector = {
        return FormDirector(collectionView: collectionView)
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.pin.top(view.pin.safeArea).horizontally().bottom()
    }

    // MARK: - Setup

    override func setupUI() {
        self.view.addSubview(collectionView)
    }

    override func setupTheme() {
        super.setupTheme()
        collectionView.theme.backgroundColor = UIColorTheme(.backgroundColor)
    }
}
