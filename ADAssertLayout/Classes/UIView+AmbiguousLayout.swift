//
//  UIView+AmbiguousLayout.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 01/04/2019.
//

import Foundation
import UIKit

/// The error thrown if a view has an ambiguous layout.
public struct AmbiguousLayoutError: LocalizedError {

    /// The view that has an ambiguous layout.
    public let view: UIView

    // MARK: - LocalizedError

    public var errorDescription: String? {
        return [
            "View has ambiguous layout.",
            "This probably means you have not added enough constraints to your view.",
            "View: \(view.ad_viewName)"
        ].joined(separator: " ")
    }
}

extension UIView {

    /// Ensures that `self` has not an ambiguous layout.
    ///
    /// An error is thrown if the condition breaks.
    public func ad_assertNoAmbiguousLayout() throws {
        if hasAmbiguousLayout {
            throw AmbiguousLayoutError(view: self)
        }
    }
}
