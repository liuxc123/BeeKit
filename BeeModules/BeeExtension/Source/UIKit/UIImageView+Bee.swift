import Foundation
import UIKit


public extension Bee where Base: UIImageView {
    @discardableResult
    func image(_ a:UIImage?) -> Bee {
        base.image = a
        return self
    }
    @discardableResult
    func highlighted(_ image:UIImage?) -> Bee {
        base.highlightedImage = image
        return self
    }
    @discardableResult
    func isHighlighted(_ a:Bool) -> Bee {
        base.isHighlighted = a
        return self
    }
    @discardableResult
    func animation(_ images:[UIImage]?) -> Bee {
        base.animationImages = images
        return self
    }
    
    @discardableResult
    func highlighted(_ animationImages:[UIImage]?) -> Bee {
        base.highlightedAnimationImages = animationImages
        return self
    }
    
    @discardableResult
    func animation(_ duration:TimeInterval) -> Bee {
        base.animationDuration = duration
        return self
    }
    @discardableResult
    func animation(_ repeatCount:Int) -> Bee {
        base.animationRepeatCount = repeatCount
        return self
    }
    @discardableResult
    func startAnimating() -> Bee {
        base.startAnimating()
        return self
    }
    @discardableResult
    func stopAnimating() -> Bee {
        base.stopAnimating()
        return self
    }
    
    @discardableResult
    func animation(_ images:[UIImage], duration:TimeInterval = 1, repeatCount:Int = 1) -> Bee {
        base.animationImages = images
        base.animationDuration = duration
        base.animationRepeatCount = repeatCount
        base.startAnimating()
        return self
    }
    @discardableResult
    func animation(_ names:[String], duration:TimeInterval = 1, repeatCount:Int = 1) -> Bee {
        //let images:[UIImage] = try names.map{ UIImage(named: $0)}
        var images:[UIImage] = []
        for item in names {
            guard let img = UIImage(named: item) else{
                assertionFailure("👉👉👉 UIImage(named: \(item))错误，请检查 names")
                continue
            }
            images.append(img)
        }
        guard images.count > 0 else {
            return self
        }
        base.animationImages = images
        base.animationDuration = duration
        base.animationRepeatCount = repeatCount
        base.startAnimating()
        return self
    }
}

