//
//  BankeyTests.swift
//  BankeyTests
//
//  Created by Diego Sierra on 07/09/23.
//

import XCTest

@testable import Bankey

final class Test: XCTestCase {

    var vc: LoginViewController!
    
    override func setUp() {
        super.setUp()
        vc = LoginViewController()
        vc.loadViewIfNeeded()
    }
    
    func testShouldBeVisible() throws {
        let isViewLoaded = vc.isViewLoaded
        XCTAssertTrue(isViewLoaded)
    }

}
