//
//  FrameComparisonTests.swift
//  AssertLayout_Example
//
//  Created by Pierre Felgines on 27/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import XCTest
@testable import AssertLayout

class FrameComparisonTests: XCTestCase {

    private var superView: UIView!
    private var innerSubview1: UIView!
    private var innerSubview2: UIView!

    override func setUp() {
        super.setUp()
        self.superView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        self.innerSubview1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 5.0))
        self.innerSubview2 = UIView(frame: CGRect(x: 5.0, y: 5.0, width: 5.0, height: 5.0))
        superView.addSubview(innerSubview1)
        superView.addSubview(innerSubview2)
    }

    // MARK: - Before

    func testBeforeLeftToRight() {
        // Success expected
        XCTAssertTrue(innerSubview1.ad_isBefore(innerSubview2))
        innerSubview1.ad_left = -1.0
        XCTAssertTrue(innerSubview1.ad_isBefore(innerSubview2))
        innerSubview1.ad_left = 0.00001
        XCTAssertTrue(innerSubview1.ad_isBefore(innerSubview2))
        innerSubview1.ad_left = 0.000001
        XCTAssertTrue(innerSubview1.ad_isBefore(innerSubview2))
        XCTAssertTrue(innerSubview1.ad_isBefore(innerSubview2, fromCenter: true))

        // Failure expected
        innerSubview1.ad_left = 0.0001
        XCTAssertFalse(innerSubview1.ad_isBefore(innerSubview2))
        innerSubview1.ad_left = 1.0
        XCTAssertFalse(innerSubview1.ad_isBefore(innerSubview2))
        innerSubview1.ad_left = 0.0
        XCTAssertFalse(innerSubview2.ad_isBefore(innerSubview1))
        innerSubview1.ad_left = 3.0
        XCTAssertFalse(innerSubview1.ad_isBefore(innerSubview2))
    }

    func testBeforeRightToLeft() {
        // TODO: (Pierre Felgines) 27/03/2019 To implement
    }

    // MARK: - After

    func testAfterLeftToRight() {
        // Success expected
        XCTAssertTrue(innerSubview2.ad_isAfter(innerSubview1))
        innerSubview2.ad_left = 6.0
        XCTAssertTrue(innerSubview2.ad_isAfter(innerSubview1))
        innerSubview2.ad_left = 4.999999
        XCTAssertTrue(innerSubview2.ad_isAfter(innerSubview1))
        innerSubview2.ad_left = 4.0
        XCTAssertTrue(innerSubview2.ad_isAfter(innerSubview1, fromCenter: true))


        // Failure expected
        innerSubview2.ad_left = 4.0
        XCTAssertFalse(innerSubview1.ad_isAfter(innerSubview2))
        innerSubview2.ad_left = 5.0
        XCTAssertFalse(innerSubview1.ad_isAfter(innerSubview2))
        innerSubview2.ad_left = 2.0
        XCTAssertFalse(innerSubview1.ad_isAfter(innerSubview2, fromCenter: true))
        innerSubview2.ad_left = 2.0
        XCTAssertFalse(innerSubview2.ad_isAfter(innerSubview1))
    }

    func testAfterRightToLeft() {
        // TODO: (Pierre Felgines) 27/03/2019 To implement
    }

    // MARK: - Above

    func testAbove() {
        // Success expected
        XCTAssertTrue(innerSubview1.ad_isAbove(innerSubview2))
        innerSubview1.ad_top = -1
        XCTAssertTrue(innerSubview1.ad_isAbove(innerSubview2))
        innerSubview1.ad_top = 0.000001
        XCTAssertTrue(innerSubview1.ad_isAbove(innerSubview2))

        // Failure expected
        innerSubview1.ad_top = 1
        XCTAssertFalse(innerSubview1.ad_isAbove(innerSubview2))
        innerSubview1.ad_top = 0
        XCTAssertFalse(innerSubview2.ad_isAbove(innerSubview1))
    }

    // MARK: - Below

    func testBelow() {
        // Success expected
        XCTAssertTrue(innerSubview2.ad_isBelow(innerSubview1))
        innerSubview2.ad_top = 6.0
        XCTAssertTrue(innerSubview2.ad_isBelow(innerSubview1))
        innerSubview2.ad_top = 4.999999
        XCTAssertTrue(innerSubview2.ad_isBelow(innerSubview1))

        // Failure expected
        innerSubview2.ad_top = 4.0
        XCTAssertFalse(innerSubview2.ad_isBelow(innerSubview1))
        innerSubview2.ad_top = 5.0
        XCTAssertFalse(innerSubview1.ad_isBelow(innerSubview2))
    }

    // MARK: - Align Start

    func testAlignStartLeftToRight() {
        innerSubview2.ad_width = 3.0 // is not right aligned

        // Success expected
        innerSubview2.ad_left = 0
        XCTAssertTrue(innerSubview1.ad_isLeadingAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isLeadingAligned(with: innerSubview1))
        innerSubview2.ad_left = 0.000001
        XCTAssertTrue(innerSubview1.ad_isLeadingAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isLeadingAligned(with: innerSubview1))
        innerSubview2.ad_left = -0.000001
        XCTAssertTrue(innerSubview1.ad_isLeadingAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isLeadingAligned(with: innerSubview1))

        // Failure expected
        innerSubview2.ad_left = 1.0
        XCTAssertFalse(innerSubview1.ad_isLeadingAligned(with: innerSubview2))
        XCTAssertFalse(innerSubview2.ad_isLeadingAligned(with: innerSubview1))
        innerSubview2.ad_left = -1.0
        XCTAssertFalse(innerSubview1.ad_isLeadingAligned(with: innerSubview2))
        XCTAssertFalse(innerSubview2.ad_isLeadingAligned(with: innerSubview1))
    }

    func testAlignStartRightToLeft() {
        // TODO: (Pierre Felgines) 27/03/2019 To implement
    }

    // MARK: - Align End

    func testAlignEndLeftToRight() {
        innerSubview2.ad_width = 3.0 // is not left aligned

        // Success expected
        innerSubview2.ad_right = 5.0
        XCTAssertTrue(innerSubview1.ad_isTrailingAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isTrailingAligned(with: innerSubview1))
        innerSubview2.ad_right = 5.000001
        XCTAssertTrue(innerSubview1.ad_isTrailingAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isTrailingAligned(with: innerSubview1))
        innerSubview2.ad_right = 4.999999
        XCTAssertTrue(innerSubview1.ad_isTrailingAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isTrailingAligned(with: innerSubview1))

        // Failure expected
        innerSubview2.ad_right = 6.0
        XCTAssertFalse(innerSubview1.ad_isTrailingAligned(with: innerSubview2))
        XCTAssertFalse(innerSubview2.ad_isTrailingAligned(with: innerSubview1))
        innerSubview2.ad_right = 4.0
        XCTAssertFalse(innerSubview1.ad_isTrailingAligned(with: innerSubview2))
        XCTAssertFalse(innerSubview2.ad_isTrailingAligned(with: innerSubview1))
    }

    func testAlignEndRightToLeft() {
        // TODO: (Pierre Felgines) 27/03/2019 To implement
    }

    // MARK: - Align Top

    func testAlignTop() {
        innerSubview2.ad_height = 3.0 // is not bottom aligned

        // Success expected
        innerSubview2.ad_top = 0
        XCTAssertTrue(innerSubview1.ad_isTopAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isTopAligned(with: innerSubview1))
        innerSubview2.ad_top = 0.000001
        XCTAssertTrue(innerSubview1.ad_isTopAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isTopAligned(with: innerSubview1))
        innerSubview2.ad_top = -0.000001
        XCTAssertTrue(innerSubview1.ad_isTopAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isTopAligned(with: innerSubview1))

        // Failure expected
        innerSubview2.ad_top = 1.0
        XCTAssertFalse(innerSubview1.ad_isTopAligned(with: innerSubview2))
        XCTAssertFalse(innerSubview2.ad_isTopAligned(with: innerSubview1))
        innerSubview2.ad_top = -1.0
        XCTAssertFalse(innerSubview1.ad_isTopAligned(with: innerSubview2))
        XCTAssertFalse(innerSubview2.ad_isTopAligned(with: innerSubview1))
    }

    // MARK: - Align Bottom

    func testAlignBottom() {
        innerSubview2.ad_height = 3.0 // is not top aligned

        // Success expected
        innerSubview2.ad_bottom = 5.0
        XCTAssertTrue(innerSubview1.ad_isBottomAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isBottomAligned(with: innerSubview1))
        innerSubview2.ad_bottom = 5.000001
        XCTAssertTrue(innerSubview1.ad_isBottomAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isBottomAligned(with: innerSubview1))
        innerSubview2.ad_bottom = 4.999999
        XCTAssertTrue(innerSubview1.ad_isBottomAligned(with: innerSubview2))
        XCTAssertTrue(innerSubview2.ad_isBottomAligned(with: innerSubview1))

        // Failure expected
        innerSubview2.ad_bottom = 6.0
        XCTAssertFalse(innerSubview1.ad_isBottomAligned(with: innerSubview2))
        XCTAssertFalse(innerSubview2.ad_isBottomAligned(with: innerSubview1))
        innerSubview2.ad_bottom = 4.0
        XCTAssertFalse(innerSubview1.ad_isBottomAligned(with: innerSubview2))
        XCTAssertFalse(innerSubview2.ad_isBottomAligned(with: innerSubview1))
    }
}
