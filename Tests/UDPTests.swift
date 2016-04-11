//
//  UDPTests.swift
//  xScanner
//
//  Created by XWJACK on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner

class UDPTests: BaseTests {

    func testUDP() {
        xSendUDP(locateAddress[1], 666)
    }
}
