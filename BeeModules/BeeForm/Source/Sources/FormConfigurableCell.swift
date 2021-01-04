import UIKit

private var formItemKey = "FormItemKey"

public protocol FormConfigurableCell {

    associatedtype CellData

    static var reuseIdentifier: String { get }
    static var itemSize: FormItemLayoutSize { get }
    static var cacheSize: Bool { get }

    func configure(with _: CellData)
}

public extension FormConfigurableCell where Self: UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var itemSize: FormItemLayoutSize {
        return FormItemLayoutSize(widthDimension: .none, heightDimension: .none)
    }

    static var cacheSize: Bool {
        return true
    }

    /// current collectionView
    var collectionView: UICollectionView? {
      var superview: UIView? = self

      while superview != nil && !(superview is UICollectionView) {
        superview = superview?.superview
      }

      return superview as? UICollectionView
    }

    /// item hashValue
    var itemHashValue: Int {
        set { objc_setAssociatedObject(self, &formItemKey, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { (objc_getAssociatedObject(self, &formItemKey) as? NSNumber)?.intValue ?? 0 }
    }

}


