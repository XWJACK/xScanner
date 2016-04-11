//
//  ICMPTests.swift
//  xScanner
//
//  Created by XWJACK on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner

class ICMPTests: BaseTests {

    func testping() {
        print(xPing(inet_addr("192.168.1.1"), 0, 3000))
        print(xPing(inet_addr("192.168.1.2"), 1, 3000))
        print(xPing(inet_addr("192.168.1.3"), 2, 3000))
    }
}
