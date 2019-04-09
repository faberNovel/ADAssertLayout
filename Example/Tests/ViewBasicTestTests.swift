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
@testable import AssertLayout

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

    func testSubviewOutOfSuperview() {
        let context = LayoutTestContext.base
        let view = ViewFactory.createSubviewOutOfSuperviewView()
        XCTAssertThrowsError(try view.ad_runBasicRecursiveTests(using: context))
    }

    func testSubviewOutOfSuperviewNoError() {
        var context = LayoutTestContext.base
        context.isViewWithinSuperviewBoundsTestEnabled = false
        let view = ViewFactory.createSubviewOutOfSuperviewView()
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
}
