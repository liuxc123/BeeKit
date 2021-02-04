//
//  UIKitAnimationViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/2/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit_Swift

class CAShapeLayerViewController: ViewController {

    lazy var containV: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.frame = CGRect(x: 50, y: 150, width: 300, height: 300)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "CAShapeLayer"

        view.addSubview(containV)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 175, y: 100))

        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 25, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        path.move(to: CGPoint(x: 150, y: 125))
        path.addLine(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 125, y: 225))
        path.move(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 175, y: 225))
        path.move(to: CGPoint(x: 100, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 150))

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.lineJoin = .round
        shapeLayer.lineCap = .round
        shapeLayer.path = path.cgPath

        self.containV.layer.addSublayer(shapeLayer)
        self.addAnimation(layer: shapeLayer, duration: 5)
    }


    func addAnimation(layer: CALayer, duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = duration
        layer.add(animation, forKey: "")
    }
}

class CATextLayerViewController: ViewController {

    lazy var containV: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 20, y: 150, width: 300, height: 500)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "CATextLayer"
        self.view.addSubview(containV)
        containV.frame = CGRect(x: 0, y: UIScreen.topBar.height, width: UIScreen.screenWidth, height: UIScreen.screenHeight - UIScreen.topBar.height)

        let textLayer = CATextLayer()
        textLayer.frame = self.containV.bounds
        self.containV.layer.addSublayer(textLayer)

        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.alignmentMode = .justified
        textLayer.isWrapped = true
        textLayer.font = UIFont.systemFont(ofSize: 15)

        let str = "文章1984年出生于陕西省西安市。上高三的时候，文章被保送到四川师范大学艺术学院学习影视表演，但是他并未进入这个学校，而是决心去北京学习。在填写大学志愿之前，文章专门去北京考察了中国两大艺术院校—北京电影学院和中央戏剧学院。回到西安之后，文章不顾父母阻拦，将大学志愿从一本到专科总共八个志愿全部填成中央戏剧学院。2002年文章被中央戏剧学院表演系录取。"
        textLayer.string = str
    }

}

class CAGradientLayerViewController: ViewController {

    lazy var containV: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 80, y: 150, width: 200, height: 200)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "CAGradientLayer"
        self.view.addSubview(containV)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.containV.bounds
        self.containV.layer.addSublayer(gradientLayer)

        let startColor = UIColor.red.cgColor
        let endColor = UIColor.blue.cgColor
        gradientLayer.colors = [startColor, endColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    }

}


class CAReplicatorLayerViewController: ViewController {

    lazy var containV: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: 150, width: view.width, height: view.height)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "CAReplicatorLayer"
        self.view.addSubview(containV)

        let replicator = CAReplicatorLayer()
        replicator.frame = self.containV.bounds
        self.containV.layer.addSublayer(replicator)

        replicator.instanceCount = 10

        var transform: CATransform3D = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 200, 0)
        transform = CATransform3DRotate(transform, .pi/5, 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -200, 0)

        replicator.instanceBlueOffset = -0.1
        replicator.instanceGreenOffset = -0.1

        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.backgroundColor = UIColor.white.cgColor
        replicator.addSublayer(layer)
    }

}

class CATransactionViewController: ViewController {

    var colorLayer: CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorLayer.position = CGPoint(x: view.width/2, y: view.height/2)
        colorLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(colorLayer)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
}
