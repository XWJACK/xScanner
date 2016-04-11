//
//  UDPTests.swift
//  xScanner
//
//  Created by 许文杰 on 4/10/16.
//  Copyright © 2016 许文杰. All rights reserved.
//

import XCTest
@testable import xScanner

class UDPTests: BaseTests {

    func testUDP() {
        xSendUDP(locateAddress[1], 666)
    }
}
