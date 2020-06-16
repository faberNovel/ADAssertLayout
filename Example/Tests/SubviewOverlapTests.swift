//
//  SubviewOverlapTests.swift
//  AssertLayout_Tests
//
//  Created by Pierre Felgines on 28/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import ADAssertLayout

// swiftlint:disable implicitly_unwrapped_optional

class SubviewOverlapTests: XCTestCase {

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

    func testOverlapTopRight() {
        innerSubview1.frame = CGRect(x: 0.0, y: 5.0, width: 6.0, height: 5.0)
        innerSubview2.frame = CGRect(x: 5.0, y: 0.0, width: 5.0, height: 6.0)
        assertOverlapingError(
            try subview.ad_assertSubviewsAreNotOverlaping(),
            view1: innerSubview1,
            view2: innerSubview2
        )
        assertOverlapingError(
            try subview.ad_recursiveAssertSubviewsAreNotOverlaping(),
            view1: innerSubview1,
            view2: innerSubview2
        )
    }

    func testOverlapTopLeft() {
        innerSubview1.frame = CGRect(x: 5.0, y: 5.0, width: 5.0, height: 5.0)
        innerSubview2.frame = CGRect(x: 0.0, y: 0.0, width: 6.0, height: 6.0)
        assertOverlapingError(
            try subview.ad_assertSubviewsAreNotOverlaping(),
            view1: innerSubview2,
            view2: innerSubview1
        )
        assertOverlapingError(
            try subview.ad_recursiveAssertSubviewsAreNotOverlaping(),
            view1: innerSubview2,
            view2: innerSubview1
        )
    }

    func testOverlapBottomRight() {
        innerSubview1.frame = CGRect(x: 0.0, y: 0.0, width: 6.0, height: 6.0)
        innerSubview2.frame = CGRect(x: 5.0, y: 5.0, width: 5.0, height: 5.0)
        assertOverlapingError(
            try subview.ad_assertSubviewsAreNotOverlaping(),
            view1: innerSubview1,
            view2: innerSubview2
        )
        assertOverlapingError(
            try subview.ad_recursiveAssertSubviewsAreNotOverlaping(),
            view1: innerSubview1,
            view2: innerSubview2
        )
    }

    func testOverlapBottomLeft() {
        innerSubview1.frame = CGRect(x: 5.0, y: 0.0, width: 5.0, height: 6.0)
        innerSubview2.frame = CGRect(x: 0.0, y: 5.0, width: 6.0, height: 5.0)
        assertOverlapingError(
            try subview.ad_assertSubviewsAreNotOverlaping(),
            view1: innerSubview2,
            view2: innerSubview1
        )
        assertOverlapingError(
            try subview.ad_recursiveAssertSubviewsAreNotOverlaping(),
            view1: innerSubview2,
            view2: innerSubview1
        )
    }

    // MARK: - Epsilon

    func testOverlapTopRightEpsilon() {
        innerSubview1.frame = CGRect(x: 0.0, y: 5.0, width: 5.0000001, height: 5.0)
        innerSubview2.frame = CGRect(x: 5.0, y: 0.0, width: 5.0, height: 5.0000001)
        XCTAssertNoThrow(try subview.ad_assertSubviewsAreNotOverlaping())
        XCTAssertNoThrow(try subview.ad_recursiveAssertSubviewsAreNotOverlaping())
    }

    func testOverlapTopLeftEpsilon() {
        innerSubview1.frame = CGRect(x: 5.0, y: 5.0, width: 5.0, height: 5.0)
        innerSubview2.frame = CGRect(x: 0.0, y: 0.0, width: 5.0000001, height: 5.0000001)
        XCTAssertNoThrow(try subview.ad_assertSubviewsAreNotOverlaping())
        XCTAssertNoThrow(try subview.ad_recursiveAssertSubviewsAreNotOverlaping())
    }

    func testOverlapBottomRightEpsilon() {
        innerSubview1.frame = CGRect(x: 0.0, y: 0.0, width: 5.0000001, height: 5.0000001)
        innerSubview2.frame = CGRect(x: 5.0, y: 5.0, width: 5.0, height: 5.0)
        XCTAssertNoThrow(try subview.ad_assertSubviewsAreNotOverlaping())
        XCTAssertNoThrow(try subview.ad_recursiveAssertSubviewsAreNotOverlaping())
    }

    func testOverlapBottomLeftEpsilon() {
        innerSubview1.frame = CGRect(x: 5.0, y: 0.0, width: 5.0, height: 5.0000001)
        innerSubview2.frame = CGRect(x: 0.0, y: 5.0, width: 5.0000001, height: 5.0)
        XCTAssertNoThrow(try subview.ad_assertSubviewsAreNotOverlaping())
        XCTAssertNoThrow(try subview.ad_recursiveAssertSubviewsAreNotOverlaping())
    }

    // MARK: - Recursive

    func testRecursiveOverlapTopRight() {
        innerSubview1.frame = CGRect(x: 0.0, y: 5.0, width: 6.0, height: 5.0)
        innerSubview2.frame = CGRect(x: 5.0, y: 0.0, width: 5.0, height: 6.0)
        assertOverlapingError(
            try superView.ad_recursiveAssertSubviewsAreNotOverlaping(),
            view1: innerSubview1,
            view2: innerSubview2
        )
    }

    func testRecursiveOverlapTopLeft() {
        innerSubview1.frame = CGRect(x: 5.0, y: 5.0, width: 5.0, height: 5.0)
        innerSubview2.frame = CGRect(x: 0.0, y: 0.0, width: 6.0, height: 6.0)
        assertOverlapingError(
            try superView.ad_recursiveAssertSubviewsAreNotOverlaping(),
            view1: innerSubview2,
            view2: innerSubview1
        )
    }

    func testRecursiveOverlapBottomRight() {
        innerSubview1.frame = CGRect(x: 0.0, y: 0.0, width: 6.0, height: 6.0)
        innerSubview2.frame = CGRect(x: 5.0, y: 5.0, width: 5.0, height: 5.0)
        assertOverlapingError(
            try superView.ad_recursiveAssertSubviewsAreNotOverlaping(),
            view1: innerSubview1,
            view2: innerSubview2
        )
    }

    func testRecursiveOverlapBottomLeft() {
        innerSubview1.frame = CGRect(x: 5.0, y: 0.0, width: 5.0, height: 6.0)
        innerSubview2.frame = CGRect(x: 0.0, y: 5.0, width: 6.0, height: 5.0)
        assertOverlapingError(
            try superView.ad_recursiveAssertSubviewsAreNotOverlaping(),
            view1: innerSubview2,
            view2: innerSubview1
        )
    }

    // MARK: - Private

    private func assertOverlapingError(_ f: @autoclosure () throws -> Void, view1: UIView, view2: UIView) {
        do {
            try f()
        } catch {
            XCTAssertEqual((error as? OverlapError)?.leftMostSubview, view1)
            XCTAssertEqual((error as? OverlapError)?.rightMostSubview, view2)
        }
    }
}
