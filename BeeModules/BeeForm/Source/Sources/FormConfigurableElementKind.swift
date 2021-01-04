import UIKit

private var formElementKindItemKey = "formElementKindItemKey"

public protocol FormConfigurableElementKind: NSObject {

    associatedtype ElementKindData

    static var reuseIdentifier: String { get }
    static var itemSize: FormItemLayoutSize { get }
    static var cacheSize: Bool { get }

    func configure(with _: ElementKindData)
}

public extension FormConfigurableElementKind where Self: UICollectionReusableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var itemSize: FormItemLayoutSize {
        return .init(widthDimension: .none, heightDimension: .none)
    }

    static var cacheSize: Bool {
        return true
    }

    var collectionView: UICollectionView? {
      var superview: UIView? = self

      while superview != nil && !(superview is UICollectionView) {
        superview = superview?.superview
      }

      return superview as? UICollectionView
    }

    /// item hashValue
    var itemHashValue: Int {
        set { objc_setAssociatedObject(self, &formElementKindItemKey, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { (objc_getAssociatedObject(self, &formElementKindItemKey) as? NSNumber)?.intValue ?? 0 }
    }

}

public class FormEmptyElementKindView: UICollectionReusableView, FormConfigurableElementKind {

    public func configure(with _: String) {}

    public static var reuseIdentifier: String {
        return "FormEmptyElementKindView"
    }
}
