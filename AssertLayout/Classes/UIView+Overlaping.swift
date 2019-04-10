//
//  UIView+Overlaping.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 28/03/2019.
//

import Foundation
import UIKit

public struct OverlapError: LocalizedError {
    public let leftMostSubview: UIView
    public let rightMostSubview: UIView

    init(subview1: UIView, subview2: UIView) {
        // Sorting subview1 and subview2 so subview1 is on the left.
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

    public func ad_recursiveAssertSubviewsAreNotOverlaping() throws {
        try ad_recursiveTraverseViewHierarchy {
            try $0.ad_assertSubviewsAreNotOverlaping()
        }
    }
}
