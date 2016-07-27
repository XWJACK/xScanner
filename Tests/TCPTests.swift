//
//  TCPTests.swift
//  xScanner
//
//  Created by Jack on 4/11/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner

class TCPTests: BaseTests {

    func testConnectWithTCP() {
        if xConnectWithTCP(locateAddresses[0], 80) {
            print("connect \(locateAddresses[0].toString()!) 80 port success")
        } else {
            print("connect \(locateAddresses[0].toString()!) 80 port fail")
        }
        if xConnectWithTCP(locateAddresses[0], 666) {
            print("connect \(locateAddresses[0].toString()!) 666 port success")
        } else {
            print("connect \(locateAddresses[0].toString()!) 666 port fail")
        }
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//            print(xConnectWithTCP(self.locateAddresses[0], 80))
//        }
//    }
}
