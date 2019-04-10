//
//  LayoutTestContext.swift
//  AssertLayout
//
//  Created by Pierre Felgines on 03/04/2019.
//

import Foundation

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
