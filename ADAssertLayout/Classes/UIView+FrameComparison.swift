//
//  UIView+FrameComparison.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 27/03/2019.
//

import Foundation
import UIKit

extension UIView {

    static var ad_epsilon: CGFloat = 0.00001

    // MARK: - Comparison

    public func ad_isBefore(_ otherView: UIView,
                            fromCenter: Bool = false) -> Bool {
        let otherViewBounds = convert(otherView.bounds, from: otherView)
        if ad_isLeftToRightLayoutDirection {
            if fromCenter {
                return center.x <= otherViewBounds.origin.x + UIView.ad_epsilon
            } else {
                return bounds.origin.x + bounds.width <= otherViewBounds.origin.x + UIView.ad_epsilon
            }
        } else {
            if fromCenter {
                return bounds.origin.x + UIView.ad_epsilon >= otherViewBounds.origin.x + otherViewBounds.width / 2.0
            } else {
                return bounds.origin.x + UIView.ad_epsilon >= otherViewBounds.origin.x + otherViewBounds.width
            }
        }
    }

    public func ad_isAfter(_ otherView: UIView, fromCenter: Bool = false) -> Bool {
        return otherView.ad_isBefore(self, fromCenter: fromCenter)
    }

    public func ad_isAbove(_ otherView: UIView) -> Bool {
        let otherViewBounds = convert(otherView.bounds, from: otherView)
        return bounds.origin.y + bounds.height <= otherViewBounds.origin.y + UIView.ad_epsilon
    }

    public func ad_isBelow(_ otherView: UIView) -> Bool {
        return otherView.ad_isAbove(self)
    }

    // MARK: - Alignment

    public func ad_isLeadingAligned(with otherView: UIView) -> Bool {
        let otherViewBounds = convert(otherView.bounds, from: otherView)
        if ad_isLeftToRightLayoutDirection {
            return abs(bounds.origin.x - otherViewBounds.origin.x) <= UIView.ad_epsilon
        } else {
            return abs(bounds.origin.x + bounds.width - otherViewBounds.origin.x - otherViewBounds.width) <= UIView.ad_epsilon
        }
    }

    public func ad_isTrailingAligned(with otherView: UIView) -> Bool {
        let otherViewBounds = convert(otherView.bounds, from: otherView)
        if ad_isLeftToRightLayoutDirection {
            return abs(bounds.origin.x + bounds.width - otherViewBounds.origin.x - otherViewBounds.width) <= UIView.ad_epsilon
        } else {
            return abs(bounds.origin.x - otherViewBounds.origin.x) <= UIView.ad_epsilon
        }
    }

    public func ad_isTopAligned(with otherView: UIView) -> Bool {
        let otherViewBounds = convert(otherView.bounds, from: otherView)
        return abs(bounds.origin.y - otherViewBounds.origin.y) <= UIView.ad_epsilon
    }

    public func ad_isBottomAligned(with otherView: UIView) -> Bool {
        let otherViewBounds = convert(otherView.bounds, from: otherView)
        return abs(bounds.origin.y + bounds.height - otherViewBounds.origin.y - otherViewBounds.height) <= UIView.ad_epsilon
    }

    // MARK: - Private

    private var ad_isLeftToRightLayoutDirection: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
    }
}
