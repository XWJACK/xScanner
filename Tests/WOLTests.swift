//
//  WOLTests.swift
//  xScanner
//
//  Created by 许文杰 on 4/10/16.
//  Copyright © 2016 许文杰. All rights reserved.
//

import XCTest
@testable import xScanner

class WOLTests: BaseTests {

    func testWeakup() {
        //3C-D9-2B-20-8B-BC
        let macAddress:[UInt8] = [0x3c, 0xd9, 0x2b, 0x20, 0x8b, 0xbc]
        xWeakOnLAN(locateEthernetInformation[2], destinationMACAddress: macAddress)
    }
}
