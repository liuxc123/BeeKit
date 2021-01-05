import Foundation
import UIKit

public extension Bee where Base: UITableView {
    
    @discardableResult
    func estimatedAll(_ height:CGFloat = CGFloat.leastNormalMagnitude) -> Bee {
        if #available(iOS 11.0, *) {
            base.estimatedRowHeight = height
            base.estimatedSectionHeaderHeight = height
            base.estimatedSectionFooterHeight = height
        }else{
            let height = height >= 2 ? height : 2
            base.estimatedRowHeight = height
            base.estimatedSectionHeaderHeight = height
            base.estimatedSectionFooterHeight = height
        }
        base.rowHeight = UITableView.automaticDimension
        base.sectionHeaderHeight = UITableView.automaticDimension
        base.sectionFooterHeight = UITableView.automaticDimension
        return self
    }
    
    @discardableResult
    func dataSource(_ d: UITableViewDataSource?) -> Bee {
        base.dataSource = d
        return self
    }
    
    @discardableResult
    func delegate(_ d: UITableViewDelegate?) -> Bee {
        base.delegate = d
        return self
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func prefetch(dataSource d: UITableViewDataSourcePrefetching?) -> Bee {
        base.prefetchDataSource = d
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func drag(delegate d: UITableViewDragDelegate?) -> Bee {
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func drop(delegate d: UITableViewDropDelegate?) -> Bee {
        base.dropDelegate = d
        return self
    }
    
    @discardableResult
    func background(view v: UIView?) -> Bee {
        base.backgroundView = v
        return self
    }
    
    @discardableResult
    func table(headerView v: UIView?) -> Bee {
        base.tableHeaderView = v
        return self
    }
    
    @discardableResult
    func table(footerView v: UIView?) -> Bee {
        base.tableFooterView = v
        return self
    }
    
    @discardableResult
    func row(height h: CGFloat) -> Bee {
        base.rowHeight = h
        return self
    }
    
    @discardableResult
    func section(headerHeight h: CGFloat) -> Bee {
        base.sectionHeaderHeight = h
        return self
    }
    
    @discardableResult
    func section(footerHeight h: CGFloat) -> Bee {
        base.sectionFooterHeight = h
        return self
    }
    
    @discardableResult
    func estimated(rowHeight h: CGFloat) -> Bee {
        base.estimatedRowHeight = h
        return self
    }
    
    @discardableResult
    func estimated(sectionHeaderHeight h: CGFloat) -> Bee {
        base.estimatedSectionHeaderHeight = h
        return self
    }
    
    @discardableResult
    func estimated(sectionFooterHeight h: CGFloat) -> Bee {
        base.estimatedSectionFooterHeight = h
        return self
    }
    
    @discardableResult
    func section(indexColor c: UIColor?) -> Bee {
        base.sectionIndexColor = c
        return self
    }
    
    @discardableResult
    func section(indexBackgroundColor c: UIColor?) -> Bee {
        base.sectionIndexBackgroundColor = c
        return self
    }
    
    @discardableResult
    func section(indexTrackingBackgroundColor c: UIColor?) -> Bee {
        base.sectionIndexTrackingBackgroundColor = c
        return self
    }
    
    @discardableResult
    func section(indexMinimumDisplayRowCount c: Int) -> Bee {
        base.sectionIndexMinimumDisplayRowCount = c
        return self
    }
    
    @discardableResult
    func separator(style s: UITableViewCell.SeparatorStyle) -> Bee {
        base.separatorStyle = s
        return self
    }
    
    @discardableResult
    func separator(color c: UIColor?) -> Bee {
        base.separatorColor = c
        return self
    }
    
    @discardableResult
    func separator(inset i: UIEdgeInsets) -> Bee {
        base.separatorInset = i
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func separator(insetReference i: UITableView.SeparatorInsetReference) -> Bee {
        base.separatorInsetReference = i
        return self
    }
}



