//
//  ViewFactory.swift
//  AssertLayout_Tests
//
//  Created by Pierre Felgines on 01/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class ErrorView: UIView {}

class ViewFactory {

    static func createNoProblemsView() -> UIView {
        let view1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        let view2 = UIView(frame: CGRect(x: 10.0, y: 0.0, width: 10.0, height: 10.0))
        let superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 10.0))
        superview.addSubview(view1)
        superview.addSubview(view2)
        return superview
    }

    static func createOverlapingView() -> UIView {
        let view1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 11.0, height: 5.0))
        let view2 = UIView(frame: CGRect(x: 10.0, y: 4.0, width: 10.0, height: 5.0))
        let superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 10.0))
        superview.addSubview(view1)
        superview.addSubview(view2)
        view1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return superview
    }

    static func createOverlapingErrorView() -> ErrorView {
        let view1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 11.0, height: 5.0))
        let view2 = UIView(frame: CGRect(x: 10.0, y: 4.0, width: 10.0, height: 5.0))
        let superview = ErrorView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 10.0))
        superview.addSubview(view1)
        superview.addSubview(view2)
        view1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return superview
    }

    static func createSubviewOutOfSuperviewView() -> UIView {
        let view1 = UIView(frame: CGRect(x: -1.0, y: 0.0, width: 10.0, height: 10.0))
        let view2 = UIView(frame: CGRect(x: 10.0, y: 0.0, width: 10.0, height: 10.0))
        let superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 10.0))
        superview.addSubview(view1)
        superview.addSubview(view2)
        view1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return superview
    }

    static func createAmbiguousLayoutView() -> UIView {
        let view1 = UIView()
        let superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        view1.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(view1)
        view1.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        // It seems that adding a window here is the only way to trigger the ambiguous layout
        let window = UIWindow()
        window.addSubview(superview)
        return superview
    }
}
