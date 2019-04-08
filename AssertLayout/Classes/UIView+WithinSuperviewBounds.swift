//
//  UIView+WithinSuperviewBounds.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 28/03/2019.
//

import Foundation
import UIKit

public struct AssertFrameViewError: LocalizedError {

    public enum Reason {
        case leftLowerThanZero
        case topLowerThanZero
        case rightGreaterThanSuperview
        case bottomGreaterThanSuperview
    }

    public let view: UIView
    public let reason: Reason

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch reason {
        case .leftLowerThanZero:
            return "X location is less than zero for \(view.ad_viewName)"
        case .topLowerThanZero:
            return "Y location is less than zero for \(view.ad_viewName)"
        case .rightGreaterThanSuperview:
            return "Right side extends past superview for \(view.ad_viewName)"
        case .bottomGreaterThanSuperview:
            return "Bottom side extends past superview for \(view.ad_viewName)"
        }
    }
}


extension UIView {

    public func ad_assertIsWithinSuperviewBounds() throws {
        guard let superview = superview else { return }
        if frame.origin.x < -UIView.ad_epsilon {
            throw AssertFrameViewError(view: self, reason: .leftLowerThanZero)
        }
        if frame.origin.y < -UIView.ad_epsilon {
            throw AssertFrameViewError(view: self, reason: .topLowerThanZero)
        }
        if frame.maxX > superview.frame.width + UIView.ad_epsilon {
            throw AssertFrameViewError(view: self, reason: .rightGreaterThanSuperview)
        }
        if frame.maxY > superview.frame.height + UIView.ad_epsilon {
            throw AssertFrameViewError(view: self, reason: .bottomGreaterThanSuperview)
        }
    }

    public func ad_recursiveAssertViewIsWithinSuperviewBounds() throws {
        try ad_recursiveTraverseViewHierarchy {
            try $0.ad_assertIsWithinSuperviewBounds()
        }
    }
}
