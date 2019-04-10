//
//  UIView+Overlaping.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 28/03/2019.
//

import Foundation
import UIKit

/// The error thrown if a two sibling views are overlaping.
public struct OverlapError: LocalizedError {

    /// The left most subview to overlap.
    public let leftMostSubview: UIView

    /// The right most subview to overlap.
    public let rightMostSubview: UIView

    /// Sorts `subview1` and `subview2` such as `subview1` is on the left.
    init(subview1: UIView, subview2: UIView) {
        if subview1.ad_left > subview2.ad_left {
            self.leftMostSubview = subview2
            self.rightMostSubview = subview1
        } else {
            self.leftMostSubview = subview1
            self.rightMostSubview = subview2
        }
    }

    // MARK: - LocalizedError

    public var errorDescription: String? {
        let rightMessage = leftMostSubview.ad_top > rightMostSubview.ad_top
            ? "Upper"
            : "Bottom"
        let leftMessage = leftMostSubview.ad_top > rightMostSubview.ad_top
            ? "bottom"
            : "upper"
        return "\(rightMessage) right corner of \(leftMostSubview.ad_viewName) overlaps \(leftMessage) left corner of \(rightMostSubview.ad_viewName)."
    }
}

extension UIView {

    /// Ensures that all direct subviews of `self` are not overlaping.
    ///
    /// An error is thrown if the condition breaks.
    public func ad_assertSubviewsAreNotOverlaping() throws {
        try (0..<subviews.count).forEach { i in
            let subview1 = subviews[i]
            try (i + 1..<subviews.count).forEach { j in
                let subview2 = subviews[j]
                guard !subview1.isHidden, !subview2.isHidden else {
                    return
                }
                if subview1.ad_bottom > subview2.ad_top + UIView.ad_epsilon
                    && subview1.ad_right > subview2.ad_left + UIView.ad_epsilon
                    && subview2.ad_bottom > subview1.ad_top + UIView.ad_epsilon
                    && subview2.ad_right > subview1.ad_left + UIView.ad_epsilon {
                    throw OverlapError(subview1: subview1, subview2: subview2)
                }
            }
        }
    }

    /// Recursively ensures that all direct subviews of `self` are not overlaping.
    ///
    /// An error is thrown if the condition breaks.
    public func ad_recursiveAssertSubviewsAreNotOverlaping() throws {
        try ad_recursiveTraverseViewHierarchy {
            try $0.ad_assertSubviewsAreNotOverlaping()
        }
    }
}
