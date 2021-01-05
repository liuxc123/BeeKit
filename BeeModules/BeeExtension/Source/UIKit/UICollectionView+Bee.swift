import Foundation
import UIKit

public extension Bee where Base: UICollectionView {
    
    @discardableResult
    func background(view v: UIView?) -> Bee {
        base.backgroundView = v
        return self
    }
    
    @discardableResult
    func layout(_ l: UICollectionViewLayout) -> Bee {
        base.collectionViewLayout = l
        return self
    }
    
    @discardableResult
    func dataSource(_ d: UICollectionViewDataSource?) -> Bee {
        base.dataSource = d
        return self
    }
    
    @discardableResult
    func delegate(_ d: UICollectionViewDelegate?) -> Bee {
        base.delegate = d
        return self
    }
    
    @discardableResult
    func prefetch(dataSource d: UICollectionViewDataSourcePrefetching?) -> Bee {
        if #available(iOS 10.0, *) {
            base.prefetchDataSource = d
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    func isPrefetching(enabled e: Bool) -> Bee {
        if #available(iOS 10.0, *) {
            base.isPrefetchingEnabled = e
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
}

