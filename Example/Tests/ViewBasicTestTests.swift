//
//  ViewBasicTestTests.swift
//  AssertLayout_Tests
//
//  Created by Pierre Felgines on 01/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import XCTest
@testable import ADAssertLayout

class ViewBasicTestTests: XCTestCase {

    func testNoProblems() {
        let context = LayoutTestContext.base
        let view = ViewFactory.createNoProblemsView()
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testOverlapingViews() {
        let context = LayoutTestContext.base
        let view = ViewFactory.createOverlapingView()
        XCTAssertThrowsError(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testOverlapingViewsNoError() {
        var context = LayoutTestContext.base
        context.isViewOverlapTestEnabled = false
        let view = ViewFactory.createOverlapingView()
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testOverlapingViewsAllowedView() {
        let view = ViewFactory.createOverlapingView()
        var context = LayoutTestContext.base
        if let subview = view.subviews.first {
            context.allowedOverlapingViews.insert(subview)
        }
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testOverlapingTableViewCell() {
        var context = LayoutTestContext.base
        context.isAmbiguousLayoutTestEnabled = false
        let view = ViewFactory.createOverlapingTableViewCell()
        XCTAssertThrowsError(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testOverlapingTableViewCellNoError() {
        var context = LayoutTestContext.base
        context.isViewOverlapTestEnabled = false
        context.isAmbiguousLayoutTestEnabled = false
        let view = ViewFactory.createOverlapingTableViewCell()
        XCTAssertNoThrow(try view.contentView.ad_runBasicRecursiveTests(using: context))
    }

    func testOverlapingViewsHidden() {
        let context = LayoutTestContext.base
        let view = ViewFactory.createOverlapingView()
        XCTAssertEqual(view.subviews.count, 2)
        view.subviews.first?.isHidden = true
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testSubviewOutOfSuperview() {
        let context = LayoutTestContext.base
        let view = ViewFactory.createSubviewOutOfSuperviewView()
        XCTAssertThrowsError(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testSubviewOutOfSuperviewHidden() {
        let context = LayoutTestContext.base
        let view = ViewFactory.createSubviewOutOfSuperviewView()
        XCTAssertEqual(view.subviews.count, 2)
        view.subviews.first?.isHidden = true
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testSubviewOutOfSuperviewWithSuperviewHidden() {
        let context = LayoutTestContext.base
        let view = ViewFactory.createSubviewOutOfSuperviewView()
        view.isHidden = true
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testSubviewOutOfSuperviewNoError() {
        var context = LayoutTestContext.base
        context.isViewWithinSuperviewBoundsTestEnabled = false
        let view = ViewFactory.createSubviewOutOfSuperviewView()
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testSubviewOutOfSuperviewAllowedView() {
        let view = ViewFactory.createSubviewOutOfSuperviewView()
        var context = LayoutTestContext.base
        if let subview = view.subviews.first {
            context.allowedFrameOutOfSuperviewViews.insert(subview)
        }
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testOverlapingErrorViews() {
        let context = LayoutTestContext.base
        let view = ViewFactory.createOverlapingErrorView()
        XCTAssertThrowsError(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testOverlapingErrorViewsNoError() {
        var context = LayoutTestContext.base
        context.viewClassNamesToSkip.insert("ErrorView")
        let view = ViewFactory.createOverlapingErrorView()
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testAmbiguousLayoutView() {
        let context = LayoutTestContext.base
        let view = ViewFactory.createAmbiguousLayoutView()
        XCTAssertThrowsError(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testAmbiguousLayoutViewNoError() {
        var context = LayoutTestContext.base
        context.isAmbiguousLayoutTestEnabled = false
        let view = ViewFactory.createAmbiguousLayoutView()
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testAmbiguousLayoutViewAllowedView() {
        let view = ViewFactory.createAmbiguousLayoutView()
        var context = LayoutTestContext.base
        if let subview = view.subviews.first {
            // If we authorize `view` for ambiguous layout, its subviews will trigger it
            context.allowedAmbiguousLayoutViews.insert(view)
            context.allowedAmbiguousLayoutViews.insert(subview)
        }
        XCTAssertNoThrow(try view.ad_runBasicRecursiveTests(using: context))
    }
}
