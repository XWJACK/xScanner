//
//  WOLTests.swift
//  xScanner
//
//  Created by Jack on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner

class WOLTests: BaseTests {

    func testWakeup() {
        let macAddress: [UInt8] = [0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff]
        xWakeOnLAN(broadcastAddress, destinationMACAddress: macAddress)
    }
}
