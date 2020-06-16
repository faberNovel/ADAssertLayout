//
//  UIView+LayoutTest.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 01/04/2019.
//

import Foundation
import UIKit

extension UIView {

    /// Run a default layout test suite, based on the context provided.
    ///
    /// - parameter context: The context that enable / disable somes of the tests.
    ///
    /// An error is throw if one of the layout assertion fails.
    public func ad_runBasicRecursiveTests(using context: LayoutTestContext = .base) throws {
        let view = viewForSubviewTesting()
        guard view == self else {
            try view.ad_runBasicRecursiveTests(using: context)
            return
        }

        try ad_recursiveTraverseViewHierarchy(
            traverseSubviews: { subview in
                subview.isValidForTesting(in: context)
            },
            block: { view in
                guard view.isValidForTesting(in: context) else { return }
                do {
                    if context.isViewWithinSuperviewBoundsTestEnabled {
                        try view.ad_assertIsWithinSuperviewBounds()
                    }
                    if context.isViewOverlapTestEnabled {
                        try view.ad_assertSubviewsAreNotOverlaping()
                    }
                    if context.isAmbiguousLayoutTestEnabled {
                        try view.ad_assertNoAmbiguousLayout()
                    }
                } catch let overlapError as OverlapError {
                    guard context.allowedOverlapingViews.contains(overlapError.leftMostSubview)
                        || context.allowedOverlapingViews.contains(overlapError.rightMostSubview) else {
                            throw overlapError
                    }
                } catch let frameError as AssertFrameViewError {
                    guard context.allowedFrameOutOfSuperviewViews.contains(frameError.view) else {
                        throw frameError
                    }
                } catch let ambiguousLayoutError as AmbiguousLayoutError {
                    guard context.allowedAmbiguousLayoutViews.contains(ambiguousLayoutError.view) else {
                        throw ambiguousLayoutError
                    }
                }
            }
        )
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
