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
    public var isAmbiguousLayoutTestEnabled = true

    // Issues with overlaping internal subviews of UITextField
    // i.e _UITextFieldRoundedRectBackgroundViewNeue and UITextFieldLabel
    public var viewClassNamesToSkip = Set<String>(["UITextField"])
}

extension UIView {

    public func ad_runBasicRecursiveTests(using context: LayoutTestContext = .base) throws {
        let view = viewForSubviewTesting()
        guard view == self else {
            try view.ad_runBasicRecursiveTests(using: context)
            return
        }

        try ad_recursiveTraverseViewHierarchy(
            traverseSubviews: { subview in
                subview.isValidForTesting(in: context)
            }
        ) { view in
            guard view.isValidForTesting(in: context) else { return }
            if context.isViewWithinSuperviewBoundsTestEnabled {
                try view.ad_assertIsWithinSuperviewBounds()
            }
            if context.isViewOverlapTestEnabled {
                try view.ad_assertSubviewsAreNotOverlaping()
            }
            if context.isAmbiguousLayoutTestEnabled {
                try view.ad_assertNoAmbiguousLayout()
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

    private func isValidForTesting(in context: LayoutTestContext) -> Bool {
        let className = String(describing: type(of: self))
        return !isHidden && !context.viewClassNamesToSkip.contains(className)
    }
}
