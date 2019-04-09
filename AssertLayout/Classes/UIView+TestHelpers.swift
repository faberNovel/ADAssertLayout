//
//  UIView+TestHelpers.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 01/04/2019.
//

import Foundation
import UIKit

/// Configuration object that defines the behavior of a layout test.
///
/// Use `LayoutTestContext.base` context as a base to create custom context.
public struct LayoutTestContext {

    /// The default context, with predefined values.
    public static let base = LayoutTestContext()

    /// Defines if an overlaping test is performed.
    ///
    /// Default value: `true`.
    public var isViewOverlapTestEnabled = true

    /// Defines if a test on superview bounds is performed.
    ///
    /// Default value: `true`.
    public var isViewWithinSuperviewBoundsTestEnabled = true

    /// Defines if an ambiguous layout test is performed.
    ///
    /// Default value: `true`.
    public var isAmbiguousLayoutTestEnabled = true

    /// Names of the view classes that should be skipped during the recursive test.
    ///
    /// For instance, there are overlaping issues with internal subviews of UITextField
    /// i.e `_UITextFieldRoundedRectBackgroundViewNeue` and `UITextFieldLabel`.
    ///
    /// Default value: `["UITextField"]`.
    public var viewClassNamesToSkip = Set<String>(["UITextField"])

    /// Set of views allowed to overlap.
    public var allowedOverlapingViews = Set<UIView>()

    /// Set of views allowed to be out of superview's bounds.
    public var allowedFrameOutOfSuperviewViews = Set<UIView>()

    /// Set of views allowed to have ambiguous layout.
    public var allowedAmbiguousLayoutViews = Set<UIView>()
}

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
            }
        ) { view in
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
