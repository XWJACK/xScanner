//
//  TCPTests.swift
//  xScanner
//
//  Created by 许文杰 on 4/11/16.
//  Copyright © 2016 许文杰. All rights reserved.
//

import XCTest
@testable import xScanner

class TCPTests: BaseTests {

    func testConnectWithTCP() {
        print(xConnectWithTCP(self.locateAddress[0], 80))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            print(xConnectWithTCP(self.locateAddress[0], 80))
        }
    }
}
