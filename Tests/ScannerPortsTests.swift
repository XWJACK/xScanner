//
//  ScannerPortsTests.swift
//  xScanner
//
//  Created by XWJACK on 4/1/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner

class ScannerPortsTests: BaseTests {

    func testScannerPortsWithTCP() {
        let scannerport = ScannerPorts(ipAddress: locateAddress[0])
        print(scannerport.xScannerPortsWithTCP())
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}
