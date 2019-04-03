//
//  UIView+Helpers.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 27/03/2019.
//

import Foundation
import UIKit

extension UIView {

    var ad_top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    var ad_bottom: CGFloat {
        get {
            return frame.origin.y + frame.height
        }
        set {
            ad_top = newValue - ad_height
        }
    }

    var ad_left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }

    var ad_right: CGFloat {
        get {
            return frame.origin.x + frame.width
        }
        set {
            ad_left = newValue - ad_width
        }
    }

    var ad_width: CGFloat {
        get {
            return frame.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    var ad_height: CGFloat {
        get {
            return frame.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }

    // MARK: - Internal

    var ad_viewName: String {
        let superviewName = superview.map { "\($0)" } ?? ""
        return "\(self) (superview: \(superviewName))"
    }

    func ad_recursiveTraverseViewHierarchy(traverseSubviews: (UIView) -> Bool = { _ in true },
                                           block: (UIView) throws -> Void) rethrows {
        try block(self)
        if traverseSubviews(self) {
            try subviews.forEach {
                try $0.ad_recursiveTraverseViewHierarchy(traverseSubviews: traverseSubviews, block: block)
            }
        }
    }
}
