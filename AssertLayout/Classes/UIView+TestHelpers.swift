//
//  UIView+TestHelpers.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 01/04/2019.
//

import Foundation
import UIKit

public struct LayoutTestContext {

    public static let base = LayoutTestContext()

    public var isViewOverlapTestEnabled = true
    public var isViewWithinSuperviewBoundsTestEnabled = true

    // Issues with overlaping internal subviews of UITextField
    // i.e _UITextFieldRoundedRectBackgroundViewNeue and UITextFieldLabel
    public var viewClassNamesToSkip = Set<String>(["UITextField"])
}

extension UIView {

    public func ad_runBasicRecursiveTests(using context: LayoutTestContext = .base) throws {
        let view = viewForSubviewTesting()
        guard view == self else {
            try view.ad_runBasicRecursiveTests()
            return
        }

        try ad_recursiveTraverseViewHierarchy(
            traverseSubviews: { subview in
                let subviewClassName = String(describing: type(of: subview))
                return !subview.isHidden
                    && !context.viewClassNamesToSkip.contains(subviewClassName)
            }
        ) { view in
            let viewClassName = String(describing: type(of: view))
            guard !context.viewClassNamesToSkip.contains(viewClassName) else {
                return
            }
            if context.isViewWithinSuperviewBoundsTestEnabled {
                try view.ad_assertIsWithinSuperviewBounds()
            }
            if context.isViewOverlapTestEnabled {
                try view.ad_assertSubviewsAreNotOverlaping()
            }
        }
    }

    // MARK: - Private

    private func viewForSubviewTesting() -> UIView {
        if let tableViewCell = self as? UITableViewCell {
            return tableViewCell.contentView
        }
        if let collectionViewCell = self as? UICollectionViewCell {
            return collectionViewCell.contentView
        }
        return self
    }
}
