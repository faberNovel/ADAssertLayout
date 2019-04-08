//
//  ViewWithinSuperviewBoundsTests.swift
//  AssertLayout_Example
//
//  Created by Pierre Felgines on 28/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import AssertLayout

class ViewWithinSuperviewBoundsTests: XCTestCase {

    private var superView: UIView!
    private var subview: UIView!
    private var innerSubview1: UIView!
    private var innerSubview2: UIView!

    override func setUp() {
        super.setUp()
        self.superView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        self.subview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        self.innerSubview1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 10.0))
        self.innerSubview2 = UIView(frame: CGRect(x: 5.0, y: 0.0, width: 5.0, height: 10.0))
        superView.addSubview(subview)
        subview.addSubview(innerSubview1)
        subview.addSubview(innerSubview2)
    }

    // MARK: - No errors

    func testNoErrorsByDefault() {
        XCTAssertNoThrow(try superView.ad_recursiveAssertSubviewsAreNotOverlaping())
        XCTAssertNoThrow(try superView.ad_recursiveAssertViewIsWithinSuperviewBounds())
    }

    // MARK: - Assert within superview bounds

    func testWithinSuperviewBoundsUpper() {
        subview.ad_top = -1.0
        assertFrameError(
            try subview.ad_assertIsWithinSuperviewBounds(),
            .topLowerThanZero
        )
        assertFrameError(
            try superView.ad_recursiveAssertViewIsWithinSuperviewBounds(),
            .topLowerThanZero
        )
    }

    func testWithinSuperviewBoundsLeft() {
        subview.ad_left = -1.0
        assertFrameError(
            try subview.ad_assertIsWithinSuperviewBounds(),
            .leftLowerThanZero
        )
        assertFrameError(
            try superView.ad_recursiveAssertViewIsWithinSuperviewBounds(),
            .leftLowerThanZero
        )
    }

    func testWithinSuperviewBoundsRight() {
        subview.ad_left = 1.0
        assertFrameError(
            try subview.ad_assertIsWithinSuperviewBounds(),
            .rightGreaterThanSuperview
        )
        assertFrameError(
            try superView.ad_recursiveAssertViewIsWithinSuperviewBounds(),
            .rightGreaterThanSuperview
        )
    }

    func testWithinSuperviewBoundsBottom() {
        subview.ad_top = 1.0
        assertFrameError(
            try subview.ad_assertIsWithinSuperviewBounds(),
            .bottomGreaterThanSuperview
        )
        assertFrameError(
            try superView.ad_recursiveAssertViewIsWithinSuperviewBounds(),
            .bottomGreaterThanSuperview
        )
    }

    func testWithinSuperviewBoundsUpperEpsilon() {
        subview.ad_top = -0.0000001
        XCTAssertNoThrow(try subview.ad_assertIsWithinSuperviewBounds())
        XCTAssertNoThrow(try superView.ad_recursiveAssertViewIsWithinSuperviewBounds())
    }

    func testWithinSuperviewBoundsLeftEpsilon() {
        subview.ad_left = -0.0000001
        XCTAssertNoThrow(try subview.ad_assertIsWithinSuperviewBounds())
        XCTAssertNoThrow(try superView.ad_recursiveAssertViewIsWithinSuperviewBounds())
    }

    func testWithinSuperviewBoundsRightEpsilon() {
        subview.ad_left = 0.0000001
        XCTAssertNoThrow(try subview.ad_assertIsWithinSuperviewBounds())
        XCTAssertNoThrow(try superView.ad_recursiveAssertViewIsWithinSuperviewBounds())
    }

    func testWithinSuperviewBoundsBottomEpsilon() {
        subview.ad_top = 0.0000001
        XCTAssertNoThrow(try subview.ad_assertIsWithinSuperviewBounds())
        XCTAssertNoThrow(try superView.ad_recursiveAssertViewIsWithinSuperviewBounds())
    }

    // MARK: - Private

    private func assertFrameError(_ f: @autoclosure () throws -> (), _ reason: AssertFrameViewError.Reason) {
        do {
            try f()
        } catch {
            XCTAssertEqual((error as? AssertFrameViewError)?.reason, reason)
        }
    }
}
