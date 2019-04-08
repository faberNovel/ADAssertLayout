//
//  ViewTraverseTests.swift
//  AssertLayout_Tests
//
//  Created by Pierre Felgines on 28/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import XCTest
@testable import AssertLayout

class ViewTraverseTests: XCTestCase {

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

    func testRecursiveTraverse() {
        var views = Set<UIView>()
        superView.ad_recursiveTraverseViewHierarchy { view in
            XCTAssertFalse(views.contains(view))
            views.insert(view)
        }
        XCTAssertTrue(views.contains(superView))
        XCTAssertTrue(views.contains(subview))
        XCTAssertTrue(views.contains(innerSubview1))
        XCTAssertTrue(views.contains(innerSubview2))
        XCTAssertEqual(views.count, 4)
    }

    func testRecursiveTraverseWithStop() {
        var views = Set<UIView>()
        superView.ad_recursiveTraverseViewHierarchy(
            traverseSubviews: { $0 != subview }
        ) { view in
            XCTAssertFalse(views.contains(view))
            views.insert(view)
        }
        XCTAssertTrue(views.contains(superView))
        XCTAssertTrue(views.contains(subview))
        XCTAssertEqual(views.count, 2)
    }

    func testRecursiveTraverseWithStopInner() {
        var views = Set<UIView>()
        superView.ad_recursiveTraverseViewHierarchy(
            traverseSubviews: { $0 != innerSubview1 }
        ) { view in
            XCTAssertFalse(views.contains(view))
            views.insert(view)
        }
        XCTAssertTrue(views.contains(superView))
        XCTAssertTrue(views.contains(subview))
        XCTAssertTrue(views.contains(innerSubview1))
        XCTAssertTrue(views.contains(innerSubview2))
        XCTAssertEqual(views.count, 4)
    }
}
