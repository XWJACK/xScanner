//
//  WOLTests.swift
//  xScanner
//
//  Created by XWJACK on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner

class WOLTests: BaseTests {

    func testWeakup() {
        let macAddress:[UInt8] = [0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff]
        xWeakOnLAN(locateEthernetInformation[2], destinationMACAddress: macAddress)
    }
}
