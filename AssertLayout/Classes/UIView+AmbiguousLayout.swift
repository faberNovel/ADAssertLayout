//
//  UIView+AmbiguousLayout.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 01/04/2019.
//

import Foundation
import UIKit

public struct AmbiguousLayoutError: LocalizedError {

    public let view: UIView

    // MARK: - LocalizedError

    public var errorDescription: String? {
        return "View has ambiguous layout. This probably means you have not added enough constraints to your view. View: \(view.ad_viewName)"
    }
}

extension UIView {

    public func ad_assertNoAmbiguousLayout() throws {
        if hasAmbiguousLayout {
            throw AmbiguousLayoutError(view: self)
        }
    }
}
